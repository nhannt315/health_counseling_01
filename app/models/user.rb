class User < ApplicationRecord
  extend FriendlyId
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  enum block_status: {blocked: 0, non_block: 1}

  friendly_id :email_slug, use: :slugged

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :notifications, dependent: :destroy, foreign_key: :receiver_id
  has_many :messages
  has_many :converstions, foreign_key: :sender_id

  mount_uploader :avatar, ImageUploader

  validates :email, presence: true,
            length: {maximum: Settings.user.email_maximum_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :name, presence: true,
            length: {maximum: Settings.user.name_maximum_length}
  validates :password, presence: true,
            length: {minimum: Settings.user.password_minimum_length},
            allow_nil: true

  scope :search, (lambda do |keyword|
    keyword = keyword.to_s.strip
    where "name LIKE ? ", "%#{sanitize_sql_like keyword}%" unless keyword.blank?
  end)

  def unchecked_notifications
    notifications.where checked: false
  end

  def current_user? user
    self == user
  end

  def email_slug
    "#{email.gsub(/@[a-z\d\-.]+\.[a-z]+\z/, '')} #{id}"
  end

  def doctor_active?
    return doctor_activated? if is_a? Doctor
    true
  end

  def self.new_with_session params, session
    super.tap do |user|
      if (data = session["devise.omniauth_data"])
        user.email = data["info"]["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth auth
    email = auth.info.email
    user = find_by email: email
    if user&.uid
      user
    elsif user && !user.uid
      user.uid = auth.uid
      user.provider = auth.provider
      user.save!
      user
    else
      User.new(email: email, name: auth.info.name)
    end
  end

  def status
    if activated?
      I18n.t "admin.users.activated"
    else
      I18n.t "admin.users.unactivated"
    end
  end
end
