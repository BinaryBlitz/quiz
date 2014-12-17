require 'test_helper'

class SessionQuestionsControllerTest < ActionController::TestCase
  def setup
    @session_question = session_questions(:one)
  end

  test "should show session question" do
    get :show, id: @session_question
    assert_response :success
  end

  test "should update session question" do
    put :update, id: @session_question, session_question: { player_points: 1, opponent_points: 2 }
    assert_response 204
  end
end
