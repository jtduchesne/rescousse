require 'rails_helper'

RSpec.describe 'UserController', type: :routing do
  it { expect(get: "/auth/facebook/callback").to route_to("user#create", provider: "facebook") }
  it { expect(get: "/auth/failure").to           route_to("user#failure") }
  
  describe "FR routing" do
    let(:é) { "%C3%A9" }
    it { expect(get: "/connexion").to      route_to("user#new",     locale: "fr") }
    it { expect(get: "/d#{é}connexion").to route_to("user#destroy", locale: "fr") }
    
    it { expect(get:   "/utilisateur").to          route_to("user#show",   locale: "fr") }
    it { expect(get:   "/utilisateur/modifier").to route_to("user#edit",   locale: "fr") }
    it { expect(put:   "/utilisateur").to          route_to("user#update", locale: "fr") }
    it { expect(patch: "/utilisateur").to          route_to("user#update", locale: "fr") }
  end
  
  describe "EN routing" do
    it { expect(get: "/login").to  route_to("user#new",     locale: "en") }
    it { expect(get: "/logout").to route_to("user#destroy", locale: "en") }
    
    it { expect(get:   "/user").to      route_to("user#show",   locale: "en") }
    it { expect(get:   "/user/edit").to route_to("user#edit",   locale: "en") }
    it { expect(put:   "/user").to      route_to("user#update", locale: "en") }
    it { expect(patch: "/user").to      route_to("user#update", locale: "en") }
  end
end
