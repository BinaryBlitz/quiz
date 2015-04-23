# == Schema Information
#
# Table name: achievements
#
#  id         :integer          not null, primary key
#  badge_id   :integer
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AchievementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
