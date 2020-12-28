require 'rails_helper'

RSpec.describe 'UserController', type: :routing do
  it { expect(get: "/auth/facebook/callback").to route_to("user#create", provider: "facebook") }
  it { expect(get: "/auth/failure").to           route_to("user#failure") }
  
  describe "FR routing" do
    let(:é) { "%C3%A9" }
    it { expect(get: "/connexion").to      route_to("user#new",     locale: "fr") }
    it { expect(get: "/d#{é}connexion").to route_to("user#destroy", locale: "fr") }
  end
  
  describe "EN routing" do
    it { expect(get: "/login").to  route_to("user#new",     locale: "en") }
    it { expect(get: "/logout").to route_to("user#destroy", locale: "en") }
  end
end
