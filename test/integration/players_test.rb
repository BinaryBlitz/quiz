require 'test_helper'

class PlayersTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
  end

  test 'should get index' do
    get "/api/players", token: token
    assert_response :success
  end

  test 'should show player' do
    get "/api/players/#{@player.id}", token: token
    assert_response :success
    assert_equal @player.name, json_response['name']
    assert_not_nil json_response['score']
    assert_not_nil json_response['total_score']
    assert_not_nil json_response['favorite_topics']
    assert_not_nil json_response['achievements']
  end

  test 'should create player' do
    player = { name: 'Foo', username: 'foo1', email: 'foo1@bar.com', password_digest: 'foobar' }
    post "/api/players", player: player
    assert_response :created
  end

  test 'should update player' do
    new_name = 'New name'
    patch "/api/players/#{@player.id}", token: token, player: { name: new_name }
    assert_response :no_content
    assert_equal new_name, @player.reload.name
  end

  test 'should destroy player' do
    assert_difference 'Player.count', -1 do
      delete "/api/players/#{@player.id}", token: token
      assert_response :no_content
    end
  end

  test 'should find player by name' do
    get "/api/players", token: token, query: 'Foo'
    assert_response :success
    assert_equal @player.name, json_response.first['name']
  end

  test 'should authenticate by name' do
    post "/api/players/authenticate",
         format: :json, username: @player.username, password_digest: @player.password_digest
    assert_response :success
    assert_not_nil json_response['token']
  end
end
