class User < ApplicationRecord
  attr_reader :password
  validates :username, presence: {message: "is missing"}, uniqueness: true
  before_validation :create_session_token
  validates :password, length: {minimum: 6, message: "is to short"}, allow_nil: true

  def self.find_by_session_token(session_token)
    self.find_by(session_token: session_token)
  end

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)

    return nil unless user
    return nil unless user.valid_password?(password)
    user
  end

  def password=(password)
    self.password_digest ||= BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def create_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
