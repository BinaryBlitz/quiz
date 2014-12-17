require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end
end
