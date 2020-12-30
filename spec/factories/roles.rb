FactoryBot.define do
  factory :role do
    association(:user)
    
    name { :usual }
  end
end
