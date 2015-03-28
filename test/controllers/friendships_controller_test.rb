require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  def setup
    @foo = players(:foo)
    @bar = players(:bar)
    @baz = players(:baz)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
  end

  test 'should create friendship' do
    post :create, token: token, format: :json, friend_id: @baz.id
    assert_response :created
    post :create, token: token, format: :json, friend_id: @baz.id
    assert_response :unprocessable_entity
  end

  test 'should destroy friendship' do
    post :unfriend, token: token, format: :json, friend_id: @bar.id
    assert_response :no_content
  end

  test 'should get requests' do
    get :requests, token: @bar.token, format: :json
    assert_response :success
    assert_equal @foo.id, json_response.first['id']
    assert_equal @foo.name, json_response.first['name']
  end
end
