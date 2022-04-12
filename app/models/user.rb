class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :currencies, dependent: :nullify
  has_many :user_bets, dependent: :destroy
  has_many :bets, through: :user_bets, dependent: :destroy
  has_many :news, dependent: :nullify
  has_many :comments, dependent: :destroy

  attr_accessor :remember_me
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: Settings.user.email.VALID_EMAIL_REGEX.freeze}
  validates :password,
            length: {in: Settings.digits.digit_6..Settings.digits.digit_21},
            allow_nil: true

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
    self.remember_me = User.new_token
    update_column :remember_digest, User.digest(remember_me)
  end

  def authenticated? remember_me
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_me)
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
