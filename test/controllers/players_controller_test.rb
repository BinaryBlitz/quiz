require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  def setup
    @player = players(:foo)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
  end

  test 'should show player' do
    get :show, token: token, format: :json, id: @player
    assert_response :success
    assert_equal @player.name, json_response['name']
    assert_not_nil json_response['score']
    assert_not_nil json_response['total_score']
    assert_not_nil json_response['favorite_topics']
    assert_not_nil json_response['achievements']
  end

  test 'should create player' do
    player = { name: 'Foo', email: 'foo1@bar.com', password_digest: 'foobar' }
    post :create, format: :json, player: player
    assert_response :created
  end

  test 'should update player' do
    new_name = 'New name'
    patch :update, token: token, format: :json, id: @player, player: { name: new_name }
    assert_response :no_content
    assert_equal new_name, @player.reload.name
  end

  test 'should destroy player' do
    assert_difference 'Player.count', -1 do
      delete :destroy, token: token, format: :json, id: @player
      assert_response :no_content
    end
  end

  test 'should find player by name' do
    get :search, token: token, format: :json, query: 'Foo'
    assert_response :success
    assert_equal @player.name, json_response.first['name']
  end
end
