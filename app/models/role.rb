class Role < ApplicationRecord
  # Attributes: name
  
  belongs_to :user
  
  validates :name, presence: true, uniqueness: true
  
  enum name: {usual: "Usual", administrator: "Administrator"}
end
