FactoryBot.define do
  factory :authentication do
    association(:user)
    
    provider { "facebook" }
    uid      { Faker::Alphanumeric.alphanumeric(number: 16) }
  end
end
