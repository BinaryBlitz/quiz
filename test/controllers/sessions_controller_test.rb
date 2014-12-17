require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @session = sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sessions)
  end
end
