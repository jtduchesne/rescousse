class Place < ApplicationRecord
  # Attributes: name, address, hood, city, province, (country), postcode,
  #                   latitude, longitude,
  #                   google_maps_id, phone, website,
  
  attr_accessor :country
  
  validates :name, presence: true, uniqueness: {scope: :city}
  validates :province, inclusion: {in: %w( QC )}
  validates :country,  inclusion: {in: %w( CA )}, on: :create
  validates :google_maps_id, presence: true
end
