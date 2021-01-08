FactoryBot.define do
  factory :item do
    name        { %w(Pinte Verre Shooter)[n % 3] }
    description { "#{name} de " + ["bière", %w(bière vin)[n % 2], "fort"][n % 3] }
    size        { ["500ml", ["300ml", "125ml"][n % 2], "30ml"][n % 3] }
    image       { ["Pinte.png", ["Verre.png", "Vin.png"][n % 2], "Shooter.png"][n % 3] }
    
    price       { [(5..10).to_a.sample, (5..10).to_a.sample, (2..5).to_a.sample][n % 3] }
    
    transient do
      sequence(:n)
    end
    
    trait :default do
      after(:create) do |item|
        create(:default_menu, items: [item])
      end
    end
  end
end
