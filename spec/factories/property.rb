FactoryBot.define do
  factory :property do
    property_type {Property.property_types.keys.sample}
    marketing_type {Property.marketing_types.keys.sample}
    lng {Faker::Address.longitude}
    lat {Faker::Address.latitude}
    house_number {Faker::Address.building_number}
    street {Faker::Address.street_name}
    city {Faker::Address.city}
    zip_code {Faker::Address.zip_code}
    state {Faker::Address.state}
    price {Faker::Number.between(from: 90000, to: 900000)}
  end

  trait :is_apartment do
    property_type {'apartment'}
  end

  trait :is_single_family_house do
    property_type {'single_family_house'}
  end

  trait :is_rent do
    marketing_type {'rent'}
  end

  trait :is_sell do
    marketing_type {'sell'}
  end
end
