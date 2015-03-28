require 'test_helper'

class GameSessionsControllerTest < ActionController::TestCase
  def setup
    @game_session = game_sessions(:offline)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
    assert_not_nil assigns(:game_sessions)
  end

  test 'should show game session' do
    get :show, format: :json, token: token, id: @game_session
    assert_response :success
  end

  test 'should close game session' do
    patch :close, format: :json, token: token, id: @game_session
    assert_response :no_content
    game_session = assigns(:game_session)
    assert game_session.closed?
  end
end
