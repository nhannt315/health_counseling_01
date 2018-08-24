FactoryBot.define do
  factory :medicine_type do
    name {Faker::Military.navy_rank}
    medicine_class {FactoryBot.create(:medicine_class)}
  end
end
