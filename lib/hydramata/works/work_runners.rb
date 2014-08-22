require 'hydramata/core/runner'
require 'hydramata/works/work'
require 'hydramata/works/work_presenter'
require 'hydramata/works/work_form'

module Hydramata
  module Works
    module WorkRunners
      class New < Hydramata::Core::Runner
        def run(work_type, attributes)
          # @TODO - Extract this to a service class
          work = Hydramata::Works::Work.new(work_type: work_type)
          presenter = Hydramata::Works::WorkPresenter.new(work: work, presentation_context: :new)
          form = Hydramata::Works::WorkForm.new(presenter)
          callback(:success, form)
        end
      end
    end
  end
end
