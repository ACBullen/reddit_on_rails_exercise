class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password
  after_initialize :ensure_session_token

  def self.find_by_credentials(username, pw)
    @user = User.find_by(username: username)

    if @user && @user.is_password?(pw)
      @user
    end
  end

  def password=(pw)
    @password = pw

    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(12)
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save
  end

  has_many  :modded_sub,
            primary_key: :id,
            foreign_key: :mod_id,
            class_name: :Sub,
            inverse_of: :moderator,
            dependent: :destroy

  has_many :posts,
           foreign_key: :author_id,
           primary_key: :id,
           class_name: :Post,
           dependent: :destroy
  has_many :comments,
           primary_key: :id,
           foreign_key: :usr_id

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
