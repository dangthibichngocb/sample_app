class User < ApplicationRecord
  before_save :downcase_email

  validates :email, presence: true,
                    length: {minimum: Settings.user.email_min,
                             maximum: Settings.user.email_max},
                    format: {with: Settings.user.email_regex},
                    uniqueness: {case_sensitive: false}

  validates :name, presence: true,
                   length: {minimum: Settings.user.name_min}

  validates :password, presence: true,
                       length: {minimum: Settings.user.password_min},
                       if: :password

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
