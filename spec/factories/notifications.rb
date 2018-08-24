FactoryBot.define do
  factory :notification do
    sender {FactoryBot.create(:user)}
    receiver {FactoryBot.create(:user)}
  end
end
