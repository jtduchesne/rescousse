class Position < ApplicationRecord
  # Attributes: ip_address, city, province, country, latitude, longitude, count
  validates :ip_address, presence: true
  
  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude
  
  before_create do
    response = self.class.client.get("/ipgeo", ip: (Rails.env.development? ? nil : ip_address))
    if response.status == 200
      JSON.parse(response.body).tap do |json|
        self.city       = json['city']
        self.province   = json['state_prov']
        self.country    = json['country_name']
        self.latitude   = json['latitude']
        self.longitude  = json['longitude']
      end
    else
      # Approximative center of province
      self.city      = "-"
      self.province  = "-"
      self.country   = "-"
      self.latitude  =  47.0707212
      self.longitude = -70.5677533
    end
  end
  
  def self.client
    @client ||= Faraday.new(url: "https://api.ipgeolocation.io",
                            params: {apiKey: Rails.application.credentials.ipgeolocation[:api_key],
                                     lang: "fr", fields: "geo",
                                     excludes: "continent_code,continent_name,country_code2,country_code3"})
  end
end
