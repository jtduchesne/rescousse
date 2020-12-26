class Authentication < ApplicationRecord
  # Attributes: provider, uid
  
  belongs_to :user, validate: true
  
  validates :provider, :uid, :presence => true
end
