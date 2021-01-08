FactoryBot.define do
  factory :menu do
    association(:place)
    
    after(:create) do |menu|
      create(:item, menus: [menu])
    end
  end
end
