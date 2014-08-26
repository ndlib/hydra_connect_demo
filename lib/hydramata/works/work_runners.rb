require 'hydramata/core/runner'

module Hydramata
  module Works
    module WorkRunners
      class New < Hydramata::Core::Runner
        def run(work_type, attributes)
          work = services.new_work_for(self, work_type, attributes)
          callback(:success, work)
        end
      end
    end
  end
end
