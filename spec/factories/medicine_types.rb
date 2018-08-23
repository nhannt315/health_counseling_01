FactoryBot.define do
  factory :medicine_type do
    name {Faker::Military.navy_rank}
  end
end
