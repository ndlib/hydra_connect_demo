require 'rails_helper'
require 'hydramata/works/work_runners'

module Hydramata
  module Works
    module WorkRunners
      describe New do

        Given(:callback) { StubCallback.new }
        Given(:callback_config) { callback.configure(:success) }
        Given(:context) { double('Context', services: services) }
        Given(:services) { double('Services', new_work_for: returning_object)}
        Given(:returning_object) { double('Returning Object') }
        Given(:work_type) { 'article' }
        Given(:attributes) { {} }

        describe New do
          Given(:runner) { described_class.new(context, &callback_config) }
          Given(:attributes) { {} }
          Given(:runner_class) { New }
          When(:result) { runner.run(work_type, attributes) }
          Then { expect(result).to eq([returning_object]) }
          And { expect(callback.invoked).to eq([:success, returning_object]) }
          And { expect(services).to have_received(:new_work_for).with(runner, work_type, attributes) }
        end

      end
    end
  end
end
