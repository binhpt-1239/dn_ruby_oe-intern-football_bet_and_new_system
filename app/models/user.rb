class User < ApplicationRecord
  has_many :currencies, dependent: :nullify
  has_many :bets, through: :user_bets, dependent: :destroy
  has_many :newses, dependent: :nullify
  has_many :comments dependent: :destroy

  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: Settings.user.email.VALID_EMAIL_REGEX.freeze}
  validates :password,
            length: {in: Settings.digits.digit_6..Settings.digits.digit_21}

  has_secure_password

  class << self
    def digest string
      min_cost = BCrypt::Engine::MIN_COST
      default_cost = BCrypt::Engine.cost
      cost = ActiveModel::SecurePassword.min_cost ? min_cost : default_cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
