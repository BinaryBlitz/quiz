require 'test_helper'

class RoomsTest < ActionDispatch::IntegrationTest
  setup do
    @owner = players(:foo)
    @guest = players(:baz)
  end

  test 'rooms' do
    # List
    get '/api/rooms', token: token
    assert_response :success

    # Create
    assert_difference 'Room.count' do
      post '/api/rooms', token: token, room: { topic_id: topics(:geography).id }
    end
    assert_response :created

    room = Room.last
    assert @owner.owned_rooms.include?(room)

    # Show
    get "/api/rooms/#{room.id}", token: token
    assert_response :success

    # Join
    post "/api/rooms/#{room.id}/join", token: @guest.token, topic_id: topics(:geography).id
    assert_response :created
    assert @guest.rooms.include?(room)

    # Leave
    delete "/api/rooms/#{room.id}/leave", token: @guest.token
    assert_response :no_content
    refute @guest.rooms.include?(room)

    # Destroy
    assert_difference 'Room.count', -1 do
      delete "/api/rooms/#{room.id}", token: token
    end
    assert_response :no_content
  end
end
