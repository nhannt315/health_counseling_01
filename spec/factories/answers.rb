FactoryBot.define do
  factory :answer do
    content {Faker::Twitter.status include_user: false}
  end
end
