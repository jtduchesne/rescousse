class Position < ApplicationRecord
  # Attributes: ip_address, city, province, country, latitude, longitude, count
  validates :ip_address, presence: true
  
  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude
end
