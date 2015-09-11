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
    @offline.send(:generate_session)

    @online = game_sessions(:online)
    @online.send(:generate_session)

    Player.all.each(&:create_stats)
  end

  test 'generation' do
    assert_equal 6, @offline.game_questions.count
    @offline.game_questions.each do |question|
      assert_includes 0..6, question.opponent_time
    end
  end

  test 'invalid without host' do
    @offline.host = nil
    assert @offline.invalid?
  end

  test 'invalid without opponent in online' do
    @online.opponent = nil
    assert @online.invalid?
  end

  test 'player points' do
    question = @online.game_questions.first
    correct_answer = question.question.correct_answer

    question.update(host_time: 0, host_answer: correct_answer)
    question.update(opponent_time: 0, opponent_answer: correct_answer)

    @online.reload
    assert_equal 20, @online.player_points(@online.host)
    assert_equal 20, @online.player_points(@online.opponent)
  end
end
