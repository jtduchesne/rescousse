class User < ApplicationRecord
  # Attributes: name, email
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@,()<>{}\[\]"'\\\/\s]+@[^@,()<>{}\[\]"'\\\/\s]+\z/ }
  
  has_many :authentications, autosave: true
  has_one :role, autosave: true
  
  def first_name
    @first_name ||= name.split(/\s+/, 2)[0]
  end
  
  def initials
    @initials ||= name.split(/\W+/).reject{|n| n.length <= 2}.first(3).map(&:first).join.upcase
  end
  
  def self.from_omniauth(auth_hash)
    User.joins(:authentications).where(authentications: {
      provider: auth_hash.fetch('provider'),
      uid:      auth_hash.fetch('uid')
    }).order(created_at: :desc).first_or_create do |user|
      auth_hash.fetch('info').tap do |info|
        user.name  = info['name']
        user.email = info['email']
      end
      user.authentications.build(auth_hash.slice('provider', 'uid'))
    end
  rescue => e
    logger.warn "User.from_omniauth() failed.\n" + 
                "  Error: " + e.inspect + "\n" +
                "  omniauth_hash: " + auth_hash.inspect
    return nil
  end
  
  def admin?
    role.present? && role.administrator?
  end
  
private
  def make_admin!
    create_role!(name: :administrator)
  end
end
