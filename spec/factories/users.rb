FactoryBot.define do
  factory :user do
    name {Faker::LordOfTheRings.character}
    email {Faker::Internet.email}
    phone_number {Faker::PhoneNumber.phone_number}
    address {Faker::Address.street_address}
    bio {Faker::HowIMetYourMother.quote}
    prof_place {Faker::LordOfTheRings.location}
    password {Faker::Lorem.sentence}
    confirmed_at {DateTime.now}
  end
end
