require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "FR routing" do
    it { expect(get: "/utilisateurs").to route_to("users#index", locale: "fr") }
    
    it { expect(post: "/utilisateurs").to route_to("users#create", locale: "fr") }
    
    it { expect(get:   "/utilisateurs/1/modifier").to route_to("users#edit", locale: "fr", id: "1") }
    it { expect(put:   "/utilisateurs/1").to          route_to("users#update", locale: "fr", id: "1") }
    it { expect(patch: "/utilisateurs/1").to          route_to("users#update", locale: "fr", id: "1") }
    
    it { expect(delete: "/utilisateurs/1").to route_to("users#destroy", locale: "fr", id: "1") }
  end
  
  describe "EN routing" do
    it { expect(get: "/users").to route_to("users#index", locale: "en") }
    
    it { expect(post: "/users").to route_to("users#create", locale: "en") }
    
    it { expect(get:   "/users/1/edit").to route_to("users#edit", locale: "en", id: "1") }
    it { expect(put:   "/users/1").to      route_to("users#update", locale: "en", id: "1") }
    it { expect(patch: "/users/1").to      route_to("users#update", locale: "en", id: "1") }
    
    it { expect(delete: "/users/1").to route_to("users#destroy", locale: "en", id: "1") }
  end
end
