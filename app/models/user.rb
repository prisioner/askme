require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy
  has_many :questions_asked, class_name: 'Question', foreign_key: 'author_id', dependent: :nullify

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  # my 'compromise' between /.+@.+/ and monster-style validation :)
  # one or more any symbols before '@', except '@'
  # only one '@'
  # one or more (sub)domain groups (one or more non-'@' symbols with point at end)
  # ends with domain-zone - one or more symbols except point or '@'
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  # at least 2 characters (maximum = 40)
  validates :username, length: { in: 2..40 }
  # may include only latin letters, numbers and underscores
  validates :username, format: { with: /\A[a-z\d_]*\z/ }

  validates :avatar_bg_color, :avatar_border_color, :profile_text_color,
            format: { with: /\A#([a-f\d]{3}){1,2}\z/i }, allow_nil: true

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  strip_attributes only: [:username, :name, :email]
  before_validation :prepare_attributes

  before_save :encrypt_password

  def prepare_attributes
    username.downcase! if username.present?
    email.downcase! if email.present?
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
