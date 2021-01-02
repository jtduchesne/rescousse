class Place < ApplicationRecord
  # Attributes: name, address, hood, city, province, (country), postcode,
  #                   latitude, longitude,
  #                   uid, phone, website,
  
  attr_accessor :number, :street, :country
  
  validates :name, presence: true, uniqueness: {scope: :city}
  validates :province, inclusion: {in: %w( QC )}
  validates :country,  inclusion: {in: %w( CA )}, on: :create
  validates :latitude, :longitude, presence: true
  validates :uid, presence: true
  
  has_and_belongs_to_many :regulars, join_table: :favorites, class_name: 'User'
  
  def number
    @number.presence || address[/^[^\s,]+/]
  end
  def street
    @street.presence || address.split(/[\s,]+/, 2)[1]
  end
  
  def fsa
    postcode[0, 3]
  end
  
  before_validation :fetch_details, on: :create
  
  def fetch_details
    response = self.class.client.get("/maps/api/place/details/json", place_id: uid)
    if response.status == 200
      json = JSON.parse(response.body)
      
      json['result'] && json['result'].tap do |result|
        result['address_components'].each do |c|
          case c['types'][0]
          when "street_number"
            self.number = c['long_name']
          when "route"
            self.street = c['long_name']
          when /sublocality/
            self.hood = c['long_name']
          when "locality"
            self.city = c['long_name']
          when "administrative_area_level_1"
            self.province = c['short_name']
          when "country"
            self.country = c['short_name']
          when "postal_code"
            self.postcode = c['long_name']
          end
        end
        self.address = [number, street].join(", ")
        self.city = "Québec" if city === /Quebec City/i
        
        self.phone   = result['formatted_phone_number'] || phone
        self.website = result['website'] || website
      end
    end
  end
  
  def self.client
    @client ||= Faraday.new(url: "https://maps.googleapis.com",
                            params: {key: Rails.application.credentials.google[:maps][:server_side],
                                     fields: "address_component,formatted_phone_number,website",
                                     language: "fr"})
  end
end
