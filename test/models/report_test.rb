# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @report = reports(:cheating)
  end
end
