require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  def setup
    @player = players(:foo)
    @booster = purchase_types(:booster)
    @unlocker = purchase_types(:unlocker)
  end

  test 'should get index' do
    get :index, token: token, format: :json
    assert_response :success
    assert_equal @booster.identifier, json_response.first['identifier']
    assert json_response.first['purchased']
    assert_not json_response.second['purchased']
  end

  test 'should purchase item' do
    post :create, token: token, format: :json, identifier: @unlocker.identifier
    assert_response :created
    assert_equal @unlocker.identifier, @player.reload.purchases.first.identifier
  end
end
