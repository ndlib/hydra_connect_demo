require 'rails_helper'
require 'hydramata/works/work_runners'

class StubCallback
  def invoke(*args)
    @invoked_args = args
  end

  def invoked(*args)
    @invoked_args
  end

  def configure(*names)
    lambda do |on|
      configure_name(on, :success)
      configure_name(on, :failure)
      names.each do |name|
        configure_name(on, name)
      end
    end
  end

  private

  def configure_name(on, name)
    on.send(name) { |*args| invoke(name, *args) }
  end
end

module Hydramata
  module Works
    module WorkRunners
      describe New do

        Given(:callback) { StubCallback.new }
        Given(:callback_config) { callback.configure(:success) }
        Given(:context) { double('Context') }
        Given(:work_type) { 'article' }
        Given(:attributes) { {} }

        describe New do
          Given(:runner) { described_class.new(context, &callback_config) }
          Given(:attributes) { {} }
          Given(:runner_class) { New }
          When(:result) { runner.run(work_type, attributes) }
          Then { expect(result[0]).to be_an_instance_of(Hydramata::Works::WorkForm) }
          And { expect(callback.invoked[0..-2]).to eq([:success]) }
          And { expect(callback.invoked[-1]).to be_an_instance_of(Hydramata::Works::WorkForm) }
        end

      end
    end
  end
end
