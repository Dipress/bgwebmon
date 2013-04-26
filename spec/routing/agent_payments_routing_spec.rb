require "spec_helper"

describe AgentPaymentsController do
  describe "routing" do

    it "routes to #index" do
      get("/agent_payments").should route_to("agent_payments#index")
    end

    it "routes to #new" do
      get("/agent_payments/new").should route_to("agent_payments#new")
    end

    it "routes to #show" do
      get("/agent_payments/1").should route_to("agent_payments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/agent_payments/1/edit").should route_to("agent_payments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/agent_payments").should route_to("agent_payments#create")
    end

    it "routes to #update" do
      put("/agent_payments/1").should route_to("agent_payments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agent_payments/1").should route_to("agent_payments#destroy", :id => "1")
    end

  end
end
