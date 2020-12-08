FactoryBot.define do
  factory :position do
    ip_address { Faker::Internet.ip_v4_address }
    city       { "Montreal" }
    province   { "Quebec" }
    country    { "Canada" }
    latitude   { 45.51240 }
    longitude  { -73.55469 }
    count      { 0 }
  end
end
