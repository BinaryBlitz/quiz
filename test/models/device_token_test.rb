# == Schema Information
#
# Table name: device_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  platform   :string
#

require 'test_helper'

class DeviceTokenTest < ActiveSupport::TestCase
  def setup
    @device_token = device_tokens(:apple)
  end
end
