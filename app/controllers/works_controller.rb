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
    run(work_type, work_attribute_params) do |on|
      on.success do |work|
        @work = work
        @work.form_options = new_and_create_form_options
        respond_with(@work)
      end
    end
  end

  def create
    run(work_type, work_attribute_params) do |on|
      on.success do |work|
        @work = work
        flash[:notice] = "#{work} was created."
        respond_with do |wants|
          wants.html { redirect_to work_path(@work) }
        end
      end
      on.created_with_invalid_data do |work|
        @work = work
        flash[:notice] = "#{work} was created but we need more information."
        respond_with do |wants|
          wants.html { redirect_to edit_work_path(@work) }
        end
      end
      on.failure do |work|
        @work = work
        flash.now[:notice] = "#{work} was not created."
        @work.form_options = new_and_create_form_options
        respond_with(@work)
      end
    end
  end

  def show
    run(work_identifier) do |on|
      on.success do |work|
        @work = work
        respond_with(@work)
      end
    end
  end

  def edit
    run(work_identifier, work_attribute_params) do |on|
      on.success do |work|
        @work = work
        @work.form_options = edit_and_update_form_options
        respond_with(@work)
      end
    end
  end

  def update
    run(work_identifier, work_attribute_params) do |on|
      on.success do |work|
        @work = work
        flash[:notice] = "#{work} was updated."
        respond_with do |wants|
          wants.html { redirect_to work_path(@work) }
        end
      end
      on.updated_with_invalid_data do |work|
        @work = work
        flash[:notice] = "#{work} was updated but we need more information."
        respond_with do |wants|
          wants.html { redirect_to edit_work_path(@work) }
        end
      end
      on.failure do |work|
        @work = work
        flash[:notice] = "#{work} could not be updated."
        @work.form_options = edit_and_update_form_options
        respond_with(@work)
      end
    end
  end

  private

  def work_attribute_params
    params.fetch(:work) { params.class.new }.permit!
  end

  def work_type
    params.require(:work_type)
  end

  def work_identifier
    params.require(:id)
  end

  def new_and_create_form_options
    { url: create_work_path(work_type: work_type), method: :post }
  end

  def edit_and_update_form_options
    { url: update_work_path(work_identifier), method: :patch }
  end
end
