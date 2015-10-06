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
    get '/api/rooms', token: token
    assert_response :success
  end

  test 'show room' do
    get "/api/rooms/#{@room.id}", token: token
    assert_response :success
  end

  test 'create rooms' do
    assert_difference 'Room.count' do
      post '/api/rooms', token: token, room: { topic_id: topics(:geography).id }
      assert_response :created
    end
    room = Room.last
    assert @owner.owned_rooms.include?(room)
  end

  test 'join room' do
    post '/api/participations.json', token: @guest.token, participation: {
      topic_id: @topic.id, room_id: @room.id
    }
    assert_response :created
    assert @guest.rooms.include?(@room)
  end

  test 'leave room' do
    participation = @room.participations.create(player: @guest, topic: @topic)
    delete "/api/participations/#{participation.id}", token: @guest.token
    assert_response :no_content
    refute @guest.rooms.include?(@room)
  end

  test 'start room' do
    post "/api/rooms/#{@room.id}/start", token: token
    assert_response :created
    assert_not_nil @room.room_session
  end

  test 'destroy rooms' do
    assert_difference 'Room.count', -1 do
      delete "/api/rooms/#{@room.id}", token: token
    end
    assert_response :no_content
  end

  test 'invite players' do
    invitee = players(:baz)

    assert_difference 'Invite.count' do
      post '/api/invites.json', token: token, invite: { room_id: @room.id, player_id: invitee.id }
      assert_response :created
    end
  end

  test 'authorize participations' do
    random_user = players(:bar)
    participation = @room.participations.create(player: @guest, topic: @topic)

    delete "/api/participations/#{participation.id}.json", token: random_user.token
    assert_response :forbidden
  end

  test 'authorize rooms for friends' do
    room = rooms(:friends_only)
    post '/api/participations.json', token: @guest.token, participation: {
      topic_id: @topic.id, room_id: room.id
    }
    assert_response :forbidden
  end

  test 'chat' do
    post "/api/rooms/#{@room.id}/messages.json",
         token: @owner.token, content: 'Hello!', room_id: @room.id
    assert_response :success
  end
end
