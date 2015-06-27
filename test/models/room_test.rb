# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  setup do
    Pusher.stubs(trigger: {})
    @player = players(:foo)
    @topic = topics(:geography)
    @room = Room.create(player: @player, topic: @topic)
  end

  test 'valid' do
    assert @room.valid?
  end

  test 'owner is a participant' do
    assert @room.players.include?(@player)
  end

  test 'players can join with topic' do
    player = players(:bar)
    topic = topics(:geometry)

    @room.join(player, topic).save
    assert @room.players.include?(player)
  end

  test 'starts the game' do
    bar = players(:bar)
    baz = players(:baz)
    @room.join(bar, @topic)
    @room.join(baz, @topic)

    @room.start

    session = @room.room_session
    assert_not_nil session
    assert_equal RoomSession::QUESTIONS_PER_PLAYER * 3, session.room_questions.count
  end
end