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
    @offline_session = game_sessions(:offline)
    @offline_session.send(:generate_session)

    @online_session = game_sessions(:online)
    @online_session.send(:generate_session)

    Player.all.each(&:create_stats)
  end

  test 'generation' do
    assert_equal 6, @offline_session.game_questions.count
    @offline_session.game_questions.each do |question|
      assert_includes 0..6, question.opponent_time
    end
  end

  test 'invalid without host' do
    @offline_session.host = nil
    assert @offline_session.invalid?
  end

  test 'invalid without opponent in online' do
    @online_session.opponent = nil
    assert @online_session.invalid?
  end

  test 'player points' do
    game_question = @online_session.game_questions.first
    correct_answer = game_question.question.correct_answer

    game_question.update!(host_time: 0, host_answer: correct_answer)
    game_question.update!(opponent_time: 0, opponent_answer: correct_answer)

    @online_session.reload
    # byebug
    assert_equal 20, @online_session.player_points(@online_session.host)
    assert_equal 20, @online_session.player_points(@online_session.opponent)
  end
end
