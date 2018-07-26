class Doctor < User
  has_many :doctor_majors, foreign_key: :user_id, dependent: :destroy
  has_many :majors, through: :doctor_majors

  mount_uploader :identity_card, ImageUploader
  mount_uploader :license, ImageUploader

  def add_majors doctor_majors
    self.major_ids = doctor_majors
  end
end
