require 'test_helper'

class CategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:general)
  end

  test 'should get index' do
    get '/api/categories', params: { token: token }
    assert_response :success
  end

  test 'should show category' do
    get '/api/categories', params: { token: token, id: @category }
    assert_response :success
  end
end
