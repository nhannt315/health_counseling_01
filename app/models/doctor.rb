class Doctor < User
  has_many :doctor_majors, dependent: :destroy
  has_many :majors, through: :doctor_majors

  validates :prof_place, presence: true
  validates :prof_spec, presence: true
  validates :identity_card, presence: true
  validates :license, presence: true
  validates :bio, presence: true
  validates :prof_position, presence: true
end
