class RunnerNotFoundError < RuntimeError # :nodoc:
  def initialize(runner_container, runner_name)
    super("Unable to find #{runner_name} in #{runner_container}")
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Because yardoc's scope imperative does not appear to work, I'm pushing the
  # comments into the class definition
  class << self
    # @!attribute [rw] runner_container
    #   So you can specify where you will be finding an action's Hydramata::Runner
    #   class.
    #
    #   @see ApplicationController#run
  end
  self.class_attribute :runner_container


  # So you can more easily decouple the controller's command behavior and
  # response behavior.
  #
  # @example
  #   def index
  #     run(specific_params) do |on|
  #       on.success { |collection|
  #         @collection = collection
  #         respond_with(@collection)
  #       }
  #     end
  #   end
  #
  # @see Hydramata::Runner More information about runners
  # @see ApplicationController.runner_container for customization
  def run(*args, &block)
    runner_name = action_name.classify
    if runner_container.const_defined?(runner_name)
      runner = runner_container.const_get(runner_name)
      runner.run(self, *args, &block)
    else
      raise RunnerNotFoundError.new(runner_container, runner_name)
    end
  end

  # So you can easily invoke the public services of Hydramata.
  # It is these services that indicate what the application can and is doing.
  #
  # @see Hydramata::Core::Services for the default services
  def services
    @services ||= Hydramata::Core::Services.new
  end
  helper_method :services

end
