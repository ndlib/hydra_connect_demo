require "spec_helper"

describe WorksController do
  describe "routing" do
    # patch 'works/:id/update', to: 'works#update', as: :update_work

    context 'GET #available_types' do
      it "routes with a work_type" do
        route = { "controller"=>"works", "action"=>"available_types" }
        expect(get("/works/available_types")).to route_to(route)
        expect(get: available_work_types_path).to route_to(route)
      end
    end

    context 'GET /works/:work_type/new' do
      it "routes with a work_type" do
        route = { "controller"=>"works", "action"=>"new", "work_type"=>"article" }
        expect(get("/works/article/new")).to route_to(route)
        expect(get: new_work_path(work_type: 'article')).to route_to(route)
      end

      it "does not route without a :work_type" do
        expect { { get: new_work_path } }.to raise_error
      end
    end

    context 'POST /works/:work_type' do
      it "routes with a work_type" do
        route = { "controller"=>"works", "action"=>"create", "work_type"=>"article" }
        expect(post("/works/article")).to route_to(route)
        expect(post: create_work_path(work_type: 'article')).to route_to(route)
      end
    end

    context 'GET /works/:id' do
      it "routes with an :id" do
        route = { "controller"=>"works", "action"=>"show", "id"=>"123" }
        expect(get("/works/123")).to route_to(route)
        expect(get: work_path(id: '123')).to route_to(route)
      end

      it "does not route without an :id" do
        expect { { get: work_path } }.to raise_error
      end
    end

    context 'GET /works/:id/edit' do
      it "routes with an :id" do
        route = { "controller"=>"works", "action"=>"edit", "id"=>"123" }
        expect(get("/works/123/edit")).to route_to(route)
        expect(get: edit_work_path(id: '123')).to route_to(route)
      end

      it "does not route without an :id" do
        expect { { get: edit_work_path } }.to raise_error
      end
    end

    context 'PUT /works/:id' do
      it "routes with an :id" do
        route = { "controller"=>"works", "action"=>"update", "id"=>"123" }
        expect(put("/works/123")).to route_to(route)
        expect(put: update_work_path(id: '123')).to route_to(route)
      end

      it "does not route without an :id" do
        expect { { put: update_work_path } }.to raise_error
      end
    end

    context 'PATCH /works/:id' do
      it "routes with an :id" do
        route = { "controller"=>"works", "action"=>"update", "id"=>"123" }
        expect(patch("/works/123")).to route_to(route)
        expect(patch: update_work_path(id: '123')).to route_to(route)
      end

      it "does not route without an :id" do
        expect { { patch: update_work_path } }.to raise_error
      end
    end
  end
end
