require 'test_helper'

class GameSessionsTest < ActionDispatch::IntegrationTest
  def setup
    @game_session = game_sessions(:offline)
  end

  test 'should get index' do
    get "/api/game_sessions", token: token
    assert_response :success
    assert_not_nil assigns(:game_sessions)
  end

  test 'should show game session' do
    get "/api/game_sessions/#{@game_session.id}", token: token
    assert_response :success
  end

  test 'should close game session' do
    patch "/api/game_sessions/#{@game_session.id}/close", token: token
    assert_response :no_content
    assert @game_session.reload.closed?
  end
end
