# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#  closed      :boolean
#  finisher_id :integer
#

require 'test_helper'

class GameSessionTest < ActiveSupport::TestCase
  def setup
    @offline = game_sessions(:offline)
    @offline.send(:generate)
    @offline.game_session_questions.each(&:generate_for_offline)

    @online = game_sessions(:online)
    @online.send(:generate)
  end

  test 'invalid without host' do
    @offline.host = nil
    assert @offline.invalid?
  end

  test 'invalid without opponent in online' do
    @online.opponent = nil
    assert @online.invalid?
  end

  test 'session creation' do
    game_session = @offline.dup
    game_session.save
    assert_equal 6, game_session.game_session_questions.count
    game_session.game_session_questions.each do |question|
      assert_includes 0..6, question.opponent_time
      assert_kind_of Answer, question.opponent_answer
    end
  end

  test 'player points' do
    question = @online.game_session_questions.first
    correct_answer = question.question.correct_answer

    assert_difference ['@online.reload.host_points', '@online.reload.opponent_points'], 20 do
      question.update(host_time: 0, host_answer: correct_answer)
      question.update(opponent_time: 0, opponent_answer: correct_answer)
    end

    assert_equal 20, @online.player_points(@online.host)
    assert_equal 20, @online.player_points(@online.opponent)
  end
end
