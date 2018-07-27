class Doctor < User
  has_many :doctor_majors, foreign_key: :user_id, dependent: :destroy
  has_many :majors, through: :doctor_majors

  mount_uploader :identity_card, ImageUploader
  mount_uploader :license, ImageUploader

  def questions
    major_ids = "SELECT major_id from doctor_majors WHERE user_id = :doctor_id"
    Question.joins(:question_categories)
            .where "major_id IN (#{major_ids})", doctor_id: id
  end

  def add_majors doctor_majors
    self.major_ids = doctor_majors
  end
end
