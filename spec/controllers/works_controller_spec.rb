require 'rails_helper'

describe WorksController do
  before(:each) do
    controller.runner_container = MockContainer.new(runner)
    allow(runner).to receive(:run).and_yield(callback)
  end
  let(:runner) { double('Runner', run: true) }
  let(:callback) { double('Callback', success: true, failure: true) }
  let(:valid_session) { { } }
  let(:work_class) { double(model_name: ActiveModel::Name.new('Work', nil, 'Work')) }
  let(:work) { double('Work', :class => work_class, :form_options= => true) }
  let(:valid_attributes) { { work_type: 'article', work: { title: 'Hello' } } }

  context "GET :new" do
    render_views(false)
    it "assigns @work" do
      expect(callback).to receive(:success).and_yield(work)
      expect(work).to receive(:form_options=).with(url: works_path(work_type: 'article'), method: :post)

      get :new, valid_attributes, valid_session

      expect(assigns(:work)).to eq(work)
      expect(runner).to have_received(:run).with(controller, valid_attributes.fetch(:work_type), valid_attributes.fetch(:work))
    end
  end

  context "POST :create" do
    render_views(false)
    let(:work) { double('Work', class: work_class, to_param: '123') }
    context 'success' do
      it "assigns @work" do
        expect(callback).to receive(:success).and_yield(work)
        allow(controller).to receive(:respond_with).and_return(true)

        expect { post :create, valid_attributes, valid_session }.to raise_error(ActionView::MissingTemplate)

        expect(assigns(:work)).to eq(work)
        expect(runner).to have_received(:run).with(controller, valid_attributes.fetch(:work_type), valid_attributes.fetch(:work))
      end
    end

    context 'failure' do
      it "assigns @work" do
        expect(callback).to receive(:failure).and_yield(work)
        allow(controller).to receive(:respond_with).and_return(true)
        expect(work).to receive(:form_options=).with(url: works_path(work_type: 'article'), method: :post)

        expect { post :create, valid_attributes, valid_session }.to raise_error(ActionView::MissingTemplate)

        expect(assigns(:work)).to eq(work)
        expect(runner).to have_received(:run).with(controller, valid_attributes.fetch(:work_type), valid_attributes.fetch(:work))
      end
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

  context "GET :show" do
    let(:work_id) { '1234' }
    render_views(false)
    it "assigns @work" do
      expect(callback).to receive(:success).and_yield(work)

      get :show, id: work_id

      expect(assigns(:work)).to eq(work)
      expect(runner).to have_received(:run).with(controller, work_id)
    end
  end

  context "GET :edit" do
    let(:work_id) { '1234' }
    render_views(false)
    it "assigns @work" do
      expect(callback).to receive(:success).and_yield(work)

      get :edit, id: work_id, work: { dc_title: 'Title' }

      expect(assigns(:work)).to eq(work)
      expect(runner).to have_received(:run).with(controller, work_id, { dc_title: 'Title' })
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
