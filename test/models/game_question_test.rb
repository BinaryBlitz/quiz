# == Schema Information
#
# Table name: game_questions
#
#  id                 :integer          not null, primary key
#  game_session_id    :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer
#  opponent_time      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class GameQuestionTest < ActiveSupport::TestCase
  def setup
    @session_question = game_questions(:session_question)
  end

  test 'invalid with negative host time' do
    @session_question.host_time = -1
    assert @session_question.invalid?
  end

  test 'invalid with negative opponent time' do
    @session_question.opponent_time = -1
    assert @session_question.invalid?
  end

  test 'offline session question creation' do
    @session_question.generate_for_offline
    assert_includes 0..6, @session_question.opponent_time
    assert_kind_of Answer, @session_question.opponent_answer
  end

  test 'invalid with answer from another question' do
    @session_question.host_answer = Answer.new(content: 'answer')
    assert @session_question.invalid?
  end
end
