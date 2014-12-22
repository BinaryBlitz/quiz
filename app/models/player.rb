# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  imei            :string
#

class Player < ActiveRecord::Base
  has_one :api_key, dependent: :destroy
  after_create :create_key

  has_secure_password
  validates :name, presence: true
  validates :password_digest, presence: true, on: :create
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  private

  def create_key
    self.create_api_key
  end
end
