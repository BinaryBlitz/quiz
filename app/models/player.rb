class Player < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  after_create :create_api_key

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, on: :create

  private

  def create_api_key
    ApiKey.create(player: self)
  end
end
