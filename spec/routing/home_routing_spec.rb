require 'rails_helper'

RSpec.describe 'HomeController', type: :routing do
  describe "routing" do
    it { expect(get: '/').to route_to("home#index") }
    it { expect(get: '/fr').to route_to("home#index", locale: "fr") }
    it { expect(get: '/en').to route_to("home#index", locale: "en") }
  end
end
