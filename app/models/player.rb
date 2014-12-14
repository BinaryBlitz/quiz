class Player < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  after_create :create_api_key

  has_secure_password
  validates :password_digest, presence: true, on: :create
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  private

  def create_api_key
    ApiKey.create(player: self)
  end
end
