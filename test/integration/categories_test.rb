require 'test_helper'

class CategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:general)
  end

  test 'should get index' do
    get '/api/categories', token: token
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test 'should show category' do
    get '/api/categories', token: token, id: @category
    assert_response :success
  end
end
