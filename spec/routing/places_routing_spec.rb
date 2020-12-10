require "rails_helper"

RSpec.describe PlacesController, type: :routing do
  describe "routing" do
    it { expect(get: "/places").to route_to("places#index") }
    
    it { expect(get:  "/places/new").to route_to("places#new") }
    it { expect(post: "/places").to     route_to("places#create") }
    
    it { expect(get:   "/places/1/edit").to route_to("places#edit", id: "1") }
    it { expect(put:   "/places/1").to      route_to("places#update", id: "1") }
    it { expect(patch: "/places/1").to      route_to("places#update", id: "1") }
    
    it { expect(delete: "/places/1").to route_to("places#destroy", id: "1") }
  end
end
