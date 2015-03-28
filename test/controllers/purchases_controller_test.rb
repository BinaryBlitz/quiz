require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  def setup
    @player = players(:foo)
    @booster = purchase_types(:booster)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
    assert_equal @booster.identifier, json_response.first['identifier']
    assert_equal false, json_response.first['purchased']
  end

  test 'should purchase item' do
    post :create, token: token, format: :json, identifier: @booster.identifier
    assert_response :created
    assert_equal @booster.identifier, @player.reload.purchases.last.identifier
  end
end
