require "spec_helper"

describe WorksController do
  describe "routing" do
    context 'GET #new' do
      it "requires a :work_type" do
        route = { "controller"=>"works", "action"=>"new", "work_type"=>"article" }
        expect(get("/works/article/new")).to route_to(route)
        expect(get: new_work_path(work_type: 'article')).to route_to(route)
      end

      it "fails without a :work_type" do
        route = { "controller"=>"works", "action"=>"new"}
        expect(get("/works/new")).to_not be_routable
        expect { { get: new_work_path } }.to raise_error
      end
    end
  end
end
