require "spec_helper"

describe ReckoningsController do
  describe "routing" do

    it "routes to #index" do
      get("/reckonings").should route_to("reckonings#index")
    end

    it "routes to #new" do
      get("/reckonings/new").should route_to("reckonings#new")
    end

    it "routes to #show" do
      get("/reckonings/1").should route_to("reckonings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reckonings/1/edit").should route_to("reckonings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reckonings").should route_to("reckonings#create")
    end

    it "routes to #update" do
      put("/reckonings/1").should route_to("reckonings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reckonings/1").should route_to("reckonings#destroy", :id => "1")
    end

  end
end
