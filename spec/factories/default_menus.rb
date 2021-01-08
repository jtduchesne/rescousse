FactoryBot.define do
  factory :default_menu do
    after(:create) do |menu|
      create(:item, default_menus: [menu])
    end
    
    trait :past do
      created_at { 1.week.ago }
    end
  end
end
