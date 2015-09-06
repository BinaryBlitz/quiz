require 'test_helper'

class PlayersTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
  end

  test 'should get index' do
    get '/api/players', token: token
    assert_response :success
  end

  test 'should show player' do
    get "/api/players/#{@player.id}", token: token
    assert_response :success
    assert_equal @player.username, json_response['username']
    # assert_not_nil json_response['score']
    assert_not_nil json_response['total_score']
    assert_not_nil json_response['favorite_topics']
    assert_not_nil json_response['achievements']
  end

  test 'should create player' do
    player = { username: 'foo1', email: 'foo1@bar.com', password: 'foobar' }
    post '/api/players', player: player
    assert_response :created
  end

  test 'should update player' do
    new_username = 'New username'
    patch "/api/players/#{@player.id}", token: token, player: { username: new_username }
    assert_response :no_content
    assert_equal new_username, @player.reload.username
  end

  test 'should destroy player' do
    assert_difference 'Player.count', -1 do
      delete "/api/players/#{@player.id}", token: token
      assert_response :no_content
    end
  end

  test 'should find player by name' do
    get '/api/players', token: token, query: 'foo'
    assert_response :success
    assert_equal @player.username, json_response.first['username']
  end

  test 'should authenticate by username' do
    post '/api/players/authenticate', username: @player.username, password: 'foobar'
    assert_response :success
    assert_not_nil json_response['token']
  end

  test 'should notify players' do
    post "/api/messages", token: token, message: { content: 'Hello!', player_id: @player.id }
    assert_response :created
  end

  test 'online status' do
    get "/api/players/#{@player.id}", token: token
    assert_response :success
    assert @player.reload.online?
  end
end
