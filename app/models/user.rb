class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :password_confirmation

  before_save :generate_api_key

  has_secure_password

  def generate_api_key
    self.api_key = SecureRandom.hex
  end
end
