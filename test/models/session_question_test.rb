# == Schema Information
#
# Table name: session_questions
#
#  id              :integer          not null, primary key
#  session_id      :integer
#  question_id     :integer
#  player_points   :integer          default("0")
#  opponent_points :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class SessionQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
