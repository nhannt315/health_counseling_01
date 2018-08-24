FactoryBot.define do
  factory :answer do
    content {Faker::Lorem.sentence}
    association(:user)
    association(:question)
  end
end
