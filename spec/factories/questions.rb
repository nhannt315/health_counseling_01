FactoryBot.define do
  factory :question do
    title {Faker::Lorem.sentence}
    content {Faker::HowIMetYourMother.quote}
    association(:user)
  end
end
