class User < ApplicationRecord
  # Attributes: name, email
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@,()<>{}\[\]"'\\\/\s]+@[^@,()<>{}\[\]"'\\\/\s]+\z/ }
end