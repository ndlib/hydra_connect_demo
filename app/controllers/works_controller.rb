require 'hydramata/works/work_runners'

class WorksController < ApplicationController
  respond_to :html, :json

  self.runner_container = Hydramata::Works::WorkRunners

  def new
    run(work_type, new_work_params) do |on|
      on.success do |work|
        @work = work
        respond_with(@work)
      end
    end
  end

  private
  def new_work_params
    params.fetch(:work) { params.class.new }.permit!
  end

  def work_type
    params.require(:work_type)
  end
end
