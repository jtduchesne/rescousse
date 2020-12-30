FactoryBot.define do
  sequence(:uid) do |n|
    "#{10000000000000 + n}"
  end
  
  factory :omniauth_hash, class: Hash do
    provider { "facebook" }
    uid      { generate :uid }
    credentials {
      { token: "FakeTokenFromOmniauthHashFactory" }
    }
    info {
      { email:    user.email,
        name:     user.name,
        verified: "true" }.merge(infos)
    }
    
    transient do
      user  { FactoryBot.build(:user) }
      infos { {} }
    end
    
    skip_create
    initialize_with { attributes.deep_stringify_keys }
  end
end
