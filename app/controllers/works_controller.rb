require 'hydramata/works/work_runners'

class WorksController < ApplicationController
  respond_to :html, :json

  self.runner_container = Hydramata::Works::WorkRunners

  def available_types
    run do |on|
      on.success do |work_types|
        @work_types = work_types
        respond_with(@work_types)
      end
    end
  end

  def new
    run(work_type, new_work_params) do |on|
      on.success do |work|
        @work = work
        @work.form_options = new_and_create_form_options
        respond_with(@work)
      end
    end
  end

  def create
    run(work_type, new_work_params) do |on|
      on.success do |work|
        @work = work
        respond_with do |wants|
          wants.html { redirect_to work_path(@work) }
        end
      end
      on.failure do |work|
        @work = work
        @work.form_options = new_and_create_form_options
        respond_with(@work)
      end
    end
  end

  def show
    run(params[:id]) do |on|
      on.success do |work|
        @work = work
        respond_with(@work)
      end
    end
  end

  private
  def new_work_params
    params.fetch(:attributes) { params.class.new }.permit!
  end

  def work_type
    params.require(:work_type)
  end

  def new_and_create_form_options
    { url: works_path(work_type: work_type), method: :post }
  end
end
