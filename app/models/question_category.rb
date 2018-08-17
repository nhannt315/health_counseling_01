class QuestionCategory < ApplicationRecord
  belongs_to :question
  belongs_to :major

  after_create_commit :notify

  private

  def notify
    Notifications::QuestionNewService.new(self).perform
  end
end
