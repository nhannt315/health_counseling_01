class Doctor < User
  has_many :doctor_majors, dependent: :destroy
  has_many :majors, through: :doctor_majors
end
