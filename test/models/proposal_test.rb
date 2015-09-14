# == Schema Information
#
# Table name: proposals
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  topic_id   :integer
#  content    :text
#  answers    :text             is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  setup do
    @proposal = proposals(:proposal)
  end

  test 'approval' do
    assert_difference 'Question.count' do
      @proposal.approve
    end
    question = Question.last
    assert_equal @proposal.content, question.content
    assert_equal @proposal.answers.count, question.answers.count
    assert_equal @proposal.answers.first, question.answers.first.content
  end
end
