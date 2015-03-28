require 'test_helper'

class AchievementsControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index, format: :json, token: token
    assert_response :success
    assert_not_nil assigns(:achievements)
  end
end
