class User < ApplicationRecord
  attr_reader :remember_token, :activation_token, :reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  enum block_status: {blocked: 0, non_block: 1}

  before_save :downcase_email
  before_create :create_activation_digest
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy, foreign_key: :receiver_id

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

  def current_user? user
    self == user
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def doctor_active?
    is_a?(Doctor) && doctor_activated?
  end

  def status
    if activated?
      I18n.t "admin.users.activated"
    else
      I18n.t "admin.users.unactivated"
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def send_mail type
    UserMailer.send(type, self).deliver_now
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def forget
    update_attributes remember_digest: nil
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def password_reset_expired?
    reset_sent_at < Settings.user.password_reset_expired.hours.ago
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest @activation_token
  end
end
