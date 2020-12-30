FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence :email do |n|
      Faker::Internet.email(name: "#{name} #{n}", separators: ".")
    end
    
    trait :authenticated do
      after(:create) do |user, evaluator|
        create(:authentication, user: user)
      end
    end
    
    trait :administrator do
      after(:create) do |user, evaluator|
        user.send :make_admin!
      end
    end
  end
end
