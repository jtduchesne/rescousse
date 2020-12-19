FactoryBot.define do
  factory :place_details_hash, class: Hash do
    skip_create
    
    status { "OK" }
    result { {
      address_components: [{
        long_name:  city,
        short_name: city,
        types: ["locality","political"]
      }],
      formatted_phone_number: phone,
      website:                website
    } }
    html_attributions { [] }
    
    transient do
      place { build :place }
      
      city    { place.city }
      phone   { place.phone }
      website { place.website }
    end
    
    initialize_with { attributes }
  end
end
