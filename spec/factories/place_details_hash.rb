FactoryBot.define do
  factory :place_details_hash, class: Hash do
    skip_create
    
    status { "OK" }
    result { {
      address_components: [{
        long_name: number, short_name: number,
        types: ["street_number"]
      }, {
        long_name: street, short_name: street,
        types: ["route"]
      }, {
        long_name: hood, short_name: hood,
        types: ["sublocality"]
      }, {
        long_name: city, short_name: city,
        types: ["locality","political"]
      }, {
        long_name: province, short_name: province,
        types: ["administrative_area_level_1","political"]
      }, {
        long_name: country, short_name: country,
        types: ["country","political"]
      }, {
        long_name: postcode, short_name: postcode,
        types: ["postal_code"]
      }],
      formatted_phone_number: phone,
      website:                website
    } }
    html_attributions { [] }
    
    transient do
      place { build :place }
      
      number   { place.number }
      street   { place.street }
      hood     { place.hood }
      city     { place.city }
      province { place.province }
      country  { place.country }
      postcode { place.postcode }
      phone    { place.phone }
      website  { place.website }
    end
    
    initialize_with { attributes }
  end
end
