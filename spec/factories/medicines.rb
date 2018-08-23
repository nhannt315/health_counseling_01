FactoryBot.define do
  factory :medicine do
    name {Faker::Lorem.word}
    company {Faker::Commerce.name}
    overview {Faker::Lorem.sentence}
    instruction {Faker::Lorem.sentence}
    info {Faker::Lorem.sentence}
    warning {Faker::Lorem.sentence}
    contraindication {Faker::Lorem.sentence}
    side_effect {Faker::Lorem.sentence}
    note {Faker::Lorem.sentence}
    overdose {Faker::Lorem.sentence}
    preservation {Faker::Lorem.sentence}
  end
end
