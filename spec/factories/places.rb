FactoryBot.define do
  factory :place do
    sequence(:name) { |n| "#{Faker::Restaurant.name} #{n.to_s}" }
    
    address  { Faker::Address.street_address.sub(/^(\d+)/, '\1,') }
    hood     { Faker::Address.community }
    city     { Faker::Address.city }
    province { "QC" }
    country  { "CA" }
    postcode { [fsa, ldu].join(" ") }
    transient do
      postal_district { %w(G H J).sample }
      fsa { postal_district + numbers.sample + letters.sample }
      ldu { letters.sample + numbers.sample + letters.sample }
      
      letters { "ABCEGHJKLMNPRSTVWXYZ".split("").freeze }
      numbers { "0123456789".split("").freeze }
    end
    
    latitude  { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    
    google_maps_id { Faker::Alphanumeric.alphanumeric(number: 16) }
    
    phone   { "(#{area_code}) #{200+rand(800)}-#{1000+rand(9000)}" }
    transient do
      area_code { {"G" => "418", "H" => "514", "J" => "819"}[postal_district] }
    end
    website { Faker::Internet.domain_name(domain: name.gsub(/[.'+ ]+/, "-")) }
  end
end
