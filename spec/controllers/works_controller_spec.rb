require 'rails_helper'

describe WorksController do
  before(:each) do
    controller.runner_container = MockContainer.new(runner)
    allow(runner).to receive(:run).and_yield(callback)
  end
  let(:runner) { double('Runner', run: true) }
  let(:callback) { double('Callback', success: true) }
  let(:valid_session) { { } }
  let(:work) { double('Work') }
  let(:valid_attributes) { { work_type: 'article', attributes: { title: 'Hello' } } }

  context "GET :new" do
    render_views(false)
    it "assigns @work" do
      expect(callback).to receive(:success).and_yield(work)

      get :new, valid_attributes, valid_session

      expect(assigns(:work)).to eq(work)
      expect(runner).to have_received(:run).with(controller, valid_attributes.fetch(:work_type), valid_attributes.fetch(:attributes))
    end
  end

  context "GET :available_types" do
    render_views(false)
    let(:work_types) { [work_type] }
    let(:work_type) { double('Work Type') }
    it "assigns @work_types" do
      expect(callback).to receive(:success).and_yield(work_types)

      get :available_types

      expect(assigns(:work_types)).to eq([work_type])
      expect(runner).to have_received(:run).with(controller)
    end
  end

  class MockContainer

    def initialize(runner)
      @runner = runner
    end

    def const_defined?(*args)
      true
    end

    def const_get(*args)
      @runner
    end

  end
end
