require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  def setup
    @foo = players(:foo)
    @bar = players(:bar)
    @baz = players(:baz)
  end

  test 'should get index' do
    get '/api/friendships', token: token
    assert_response :success
  end

  test 'should create friendship' do
    post '/api/friendships', token: token, friend_id: @baz.id
    assert_response :created
    post '/api/friendships', token: token, friend_id: @baz.id
    assert_response :unprocessable_entity
  end

  test 'should destroy friendship' do
    delete '/api/friendships/unfriend', token: token, friend_id: @bar.id
    assert_response :no_content
  end

  test 'should get requests' do
    get '/api/friendships/requests', token: @bar.token
    assert_response :success
    assert_equal @foo.id, json_response.first['id']
    assert_equal @foo.name, json_response.first['name']
  end
end
