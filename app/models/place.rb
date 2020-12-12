class Place < ApplicationRecord
  # Attributes: name, address, hood, city, province, postcode,
  #                   latitude, longitude,
  #                   phone, email, website
  
  validates :name, presence: true, uniqueness: {scope: :city}
end
