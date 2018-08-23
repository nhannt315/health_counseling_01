FactoryBot.define do
  factory :disease do
    name {Faker::Pokemon.name}
    content_html {Faker::Lorem.sentence}
  end
end
