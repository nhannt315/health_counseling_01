FactoryBot.define do
  factory :medicine_class do
    name {Faker::Military.navy_rank}
  end
end
