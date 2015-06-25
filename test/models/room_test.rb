# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  setup do
    @room = rooms(:room)
  end

  test 'valid' do
    assert @room.valid?
  end

  test 'join' do
    bar = players(:bar)
    topic = topics(:geometry)

    @room.join(bar, topic)
    assert @room.players.include?(bar)
  end

  test 'starts the game' do
    bar = players(:bar)
    baz = players(:baz)
    @room.join(bar, topics(:geometry))
    @room.join(baz, topics(:geography))

    @room.start

    session = @room.room_session
    assert_not_nil session
    assert_equal RoomSession::QUESTIONS_PER_PLAYER, session.room_questions.count
  end
end
