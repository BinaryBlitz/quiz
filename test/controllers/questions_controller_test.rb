require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { text: @question.text, answers: @question.answers,
        correct_answer: @question.correct_answer }
    end

    assert_response 201
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should update question" do
    put :update, id: @question, question: { text: 'New question' }
    assert_response :no_content
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_response :no_content
  end
end
