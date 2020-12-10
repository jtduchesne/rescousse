require "rails_helper"

RSpec.describe PlacesController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/endroits").to route_to("places#index", locale: "fr") }
    
    it { expect(post: "/endroits").to route_to("places#create", locale: "fr") }
    
    it { expect(get:   "/endroits/1/modifier").to route_to("places#edit", locale: "fr", id: "1") }
    it { expect(put:   "/endroits/1").to          route_to("places#update", locale: "fr", id: "1") }
    it { expect(patch: "/endroits/1").to          route_to("places#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/endroits/1").to route_to("places#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/places").to route_to("places#index", locale: "en") }
    
    it { expect(post: "/places").to route_to("places#create", locale: "en") }
    
    it { expect(get:   "/places/1/edit").to route_to("places#edit", locale: "en", id: "1") }
    it { expect(put:   "/places/1").to      route_to("places#update", locale: "en", id: "1") }
    it { expect(patch: "/places/1").to      route_to("places#update", locale: "en", id: "1") }
    
    it { expect(delete: "/places/1").to route_to("places#destroy", locale: "en", id: "1") }
  end
end
