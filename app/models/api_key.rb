# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  token      :string
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApiKey < ActiveRecord::Base
  before_create :generate_token
  belongs_to :player

  def to_s
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex
  end
end
