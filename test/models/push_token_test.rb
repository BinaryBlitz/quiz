# == Schema Information
#
# Table name: push_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  android    :boolean          default(FALSE)
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PushTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
