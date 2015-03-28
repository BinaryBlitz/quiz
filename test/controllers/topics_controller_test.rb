require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
    @geography = topics(:geography)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
  end

  test 'should show topic' do
    get :show, token: token, format: :json, id: @geography
    assert_response :success
    assert_equal @geography.name, json_response['name']
  end
end
