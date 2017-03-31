require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  def setup
    @foo = players(:foo)
    @bar = players(:baz)
  end

  # TODO: Refactor
  test 'friends' do
    # Create friend request
    post '/api/friend_requests', params: { token: token, friend_id: @bar.id }
    assert_response :created
    assert @foo.pending_friends.include?(@bar)

    # List friend requests
    get '/api/friend_requests', params: { token: token }
    assert_response :success

    # Accept friend request
    patch "/api/friend_requests/#{FriendRequest.last.id}", params: { token: @bar.token }
    assert_response :no_content
    assert @foo.friends.include?(@bar)

    # List friends
    get '/api/friends', params: { token: token }
    assert_response :success

    # Remove friends
    delete "/api/friends/#{@bar.id}", params: { token: token }
    assert_response :no_content
    assert_not @foo.friends.include?(@bar)
  end
end
