FactoryBot.define do
  factory :question do
    title {Faker::Lorem.word}
    content {Faker::HowIMetYourMother.quote}
  end
end
