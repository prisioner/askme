require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  # my 'compromise' between /.+@.+/ and monster-style validation :)
  # one or more any symbols before '@', except '@'
  # only one '@'
  # one or more (sub)domain groups (one or more non-'@' symbols with point at end)
  # ends with domain-zone - one or more symbols except point or '@'
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/ }

  # at least 2 characters (maximum = 40)
  validates :username, length: { in: 2..40 }
  # may include only latin letters, numbers and underscopes
  validates :username, format: { with: /\A[a-z\d_]*\Z/, message: I18n.t('errors.username.format.symbols') }
  # starts with latin letter
  validates :username, format: { with: /\A[^_\d]/, message: I18n.t('errors.username.format.underscore_or_digit_on_start') }
  # ends with latin letter or digit
  validates :username, format: { with: /[^_]\Z/, message: I18n.t('errors.username.format.underscore_on_end') }
  # may not include following underscopes
  validates :username, format: { with: /\A((?!__).)*\Z/, message: I18n.t('errors.username.format.following_underscores') }


  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password
  before_validation :prepare_attributes

  def prepare_attributes
    if username.present?
      username.strip!
      username.downcase!
    end

    if email.present?
      email.strip!
      email.downcase!
    end

    name.strip! if name.present?
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email:, password:)
    email.downcase!
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end
