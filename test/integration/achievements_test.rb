require 'test_helper'

class AchievementsTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get '/api/achievements', token: token
    assert_response :success
  end
end
