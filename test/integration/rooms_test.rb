require 'test_helper'

class RoomsTest < ActionDispatch::IntegrationTest
  setup do
    Pusher.stubs(trigger: {})
    @owner = players(:foo)
    @guest = players(:baz)
    @topic = topics(:geography)

    @room = rooms(:room)
    @room.topic = @topic
    @room.run_callbacks(:create)
  end

  test 'list rooms' do
    get '/api/rooms', params: { token: token }
    assert_response :success
  end

  test 'show room' do
    get "/api/rooms/#{@room.id}", params: { token: token }
    assert_response :success
  end

  test 'create rooms' do
    assert_difference 'Room.count' do
      post '/api/rooms', params: {
        token: token,
        room: { topic_id: topics(:geography).id }
      }
      assert_response :created
    end
    room = Room.last
    assert @owner.owned_rooms.include?(room)
  end

  test 'join room' do
    post '/api/participations.json', params: {
      token: @guest.token,
      participation: { topic_id: @topic.id, room_id: @room.id }
    }
    assert_response :created
    assert @guest.rooms.include?(@room)
  end

  test 'leave room' do
    participation = @room.participations.create(player: @guest, topic: @topic)
    delete "/api/participations/#{participation.id}", params: { token: @guest.token }
    assert_response :no_content
    refute @guest.rooms.include?(@room)
  end

  test 'start room' do
    post "/api/rooms/#{@room.id}/start", params: { token: token }
    assert_response :created
    assert_not_nil @room.room_session
  end

  test 'destroy rooms' do
    assert_difference 'Room.count', -1 do
      delete "/api/rooms/#{@room.id}", params: { token: token }
    end
    assert_response :no_content
  end

  test 'invite players' do
    invitee = players(:baz)

    assert_difference 'Invite.count' do
      post '/api/invites.json', params: {
        token: token,
        invite: { room_id: @room.id, player_id: invitee.id }
      }
      assert_response :created
    end
  end

  test 'authorize participations' do
    random_user = players(:baz)
    participation = @room.participations.create(player: @guest, topic: @topic)

    delete "/api/participations/#{participation.id}.json", params: { token: random_user.token }
    assert_response :forbidden
  end

  test 'authorize rooms for friends' do
    room = rooms(:friends_only)
    post '/api/participations.json', params: {
      token: @guest.token,
      participation: { topic_id: @topic.id, room_id: room.id }
    }
    assert_response :forbidden
  end

  test 'chat' do
    post "/api/rooms/#{@room.id}/messages.json", params: {
      token: @owner.token,
      content: 'Hello!',
      room_id: @room.id
    }
    assert_response :success
  end
end
