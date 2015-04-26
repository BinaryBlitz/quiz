require 'test_helper'

class PurchasesTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
    @booster = purchase_types(:booster)
    @unlocker = purchase_types(:unlocker)
  end

  test 'should get index' do
    get "/api/purchases", token: token
    assert_response :success
    assert_equal @booster.identifier, json_response.first['identifier']
    assert json_response.first['purchased']
    assert_not json_response.second['purchased']
  end

  test 'should purchase item' do
    post "/api/purchases", token: token, identifier: @unlocker.identifier
    assert_response :created
    assert_equal @unlocker.identifier, @player.reload.purchases.first.identifier
  end
end
