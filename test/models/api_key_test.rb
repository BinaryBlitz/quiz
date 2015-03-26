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

require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  def setup
    @api_key = api_keys(:api_key_one)
  end

  test 'uniqueness' do
    copy = ApiKey.new(token: @api_key.token)
    assert_not copy.valid?
  end
end
