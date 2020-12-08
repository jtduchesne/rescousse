FactoryBot.define do
  factory :geolocation_hash, class: Hash do
    skip_create
    
    ip           { Faker::Internet.ip_v4_address }
    city         { "IP-Montreal" }
    state_prov   { "IP-Quebec" }
    country_name { "IP-Canada" }
    latitude     {  45.51250 }
    longitude    { -73.55479 }
    
    initialize_with { attributes }
  end
end
