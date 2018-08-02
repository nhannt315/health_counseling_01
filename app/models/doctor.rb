class Doctor < User
  has_many :doctor_majors, foreign_key: :user_id, dependent: :destroy
  has_many :majors, through: :doctor_majors

  mount_uploader :identity_card, ImageUploader
  mount_uploader :license, ImageUploader

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    where "name LIKE ? ", "%#{sanitize_sql_like keyword}%" unless keyword.blank?
  end)

  def questions
    major_ids = "SELECT major_id from doctor_majors WHERE user_id = :doctor_id"
    Question.joins(:question_categories)
            .where "major_id IN (#{major_ids})", doctor_id: id
  end

  def status
    if doctor_activated?
      I18n.t("admin.doctors.activated")
    else
      I18n.t("admin.doctors.pending")
    end
  end

  def activate
    update_attributes doctor_activated: true
  end

  def add_majors doctor_majors
    self.major_ids = doctor_majors
  end
end
