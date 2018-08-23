require "rails_helper"

RSpec.describe Notification, type: :model do
  let!(:sender) {create(:user, confirmed_at: DateTime.now)}
  let!(:receiver) {create(:user, confirmed_at: DateTime.now)}
  let!(:category) {create(:major)}
  let!(:question) {create(:question, user: sender)}
  let!(:question_receiver) {create(:question, user: receiver)}
  let!(:answer) {create(:answer, user: sender, question: question)}
  let!(:answer_receiver) do
    create(:answer, user: sender,
           question: question_receiver)
  end
  let!(:question_category) do
    create(:question_category,
           question: question, major: category)
  end
  let!(:notification_doctor) do
    create(:notification, sender: sender, receiver: receiver,
           notifiable: question_category)
  end
  let!(:notification_user) do
    create(:notification, sender: sender, receiver: receiver,
           notifiable: answer)
  end
  let!(:notification_answer) do
    create(:notification, sender: sender, receiver: receiver,
           notifiable: answer_receiver)
  end
  describe "associations" do
    it {is_expected.to belong_to :sender}
    it {is_expected.to belong_to :receiver}
    it {is_expected.to belong_to :notifiable}
  end

  it "instance method" do
    expect(notification_doctor.content).to eq(
      doctor_noti_content notification_doctor.notifiable
    )
    expect(notification_user.content).to eq(
      user_noti_answer_content notification_answer.notifiable
    )
    expect(notification_answer.content).to eq(
      user_noti_content notification_user.notifiable
    )
  end
end
