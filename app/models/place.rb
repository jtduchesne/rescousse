class Place < ApplicationRecord
  # Attributes: name, address, hood, city, province, (country), postcode,
  #                   latitude, longitude,
  #                   google_maps_id, phone, website,
  
  attr_accessor :country
  
  validates :name, presence: true, uniqueness: {scope: :city}
  validates :province, inclusion: {in: %w( QC )}
  validates :country,  inclusion: {in: %w( CA )}, on: :create
  validates :google_maps_id, presence: true
  
  before_validation :fetch_contact, on: :create
  
  def fetch_contact
    response = self.class.client.get("/maps/api/place/details/json", place_id: google_maps_id)
    if response.status == 200
      json = JSON.parse(response.body)
      
      json['result'] && json['result'].tap do |result|
        self.phone   = result['formatted_phone_number'] || phone
        self.website = result['website'] || website
      end
    end
  end
  
  def self.client
    @client ||= Faraday.new(url: "https://maps.googleapis.com",
                            params: {key: Rails.application.credentials.google[:maps][:server_side],
                                     fields: "formatted_phone_number,website",
                                     language: "fr"})
  end
end
