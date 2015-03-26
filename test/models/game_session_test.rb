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
#  finished    :boolean          default(FALSE)
#  closed      :boolean
#  finisher_id :integer
#

require 'test_helper'

class GameSessionTest < ActiveSupport::TestCase
  def setup
    @offline_session = game_sessions(:offline)
    @offline_session.send(:generate)
    @offline_session.game_session_questions.each(&:generate_for_offline)

    @online_session = game_sessions(:online)
  end

  test 'invalid without host' do
    @offline_session.host = nil
    assert @offline_session.invalid?
  end

  test 'invalid without opponent in online' do
    @online_session.opponent = nil
    assert @online_session.invalid?
  end

  test 'session creation' do
    assert_equal 6, @offline_session.game_session_questions.count
    @offline_session.game_session_questions.each do |question|
      assert_includes 0..6, question.opponent_time
      assert_kind_of Answer, question.opponent_answer
    end
  end
end
