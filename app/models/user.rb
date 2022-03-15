class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: Settings.user.email.VALID_EMAIL_REGEX.freeze}
  validates :password,
            length: {in: Settings.digits.digit_6..Settings.digits.digit_21}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
