FactoryBot.define do
  factory :booking do
    doctor_id {FactoryBot.create(:user, type: :Doctor).id}
    user_id {FactoryBot.create(:user).id}
    title {Faker::Lorem.word}
    start_time {DateTime.now}
    stop_time {DateTime.now}
    category_id {FactoryBot.create(:major).id}
    location {Faker::LordOfTheRings.location}
    state {Faker::Lorem.word}
    schedule_type {Faker::Lorem.word}
    reason {Faker::Lorem.sentence}
  end
end
