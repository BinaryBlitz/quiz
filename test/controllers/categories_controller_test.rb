require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = categories(:general)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test 'should show category' do
    get :show, format: :json, token: token, id: @category
    assert_response :success
  end
end
