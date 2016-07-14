require "rails_helper"

RSpec.describe AilmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ailments").to route_to("ailments#index")
    end

    it "routes to #new" do
      expect(:get => "/ailments/new").to route_to("ailments#new")
    end

    it "routes to #show" do
      expect(:get => "/ailments/1").to route_to("ailments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ailments/1/edit").to route_to("ailments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ailments").to route_to("ailments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ailments/1").to route_to("ailments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ailments/1").to route_to("ailments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ailments/1").to route_to("ailments#destroy", :id => "1")
    end

  end
end
