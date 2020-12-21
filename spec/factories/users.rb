FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence :email do |n|
      Faker::Internet.email(name: "#{name} #{n}", separators: ".")
    end
  end
end
