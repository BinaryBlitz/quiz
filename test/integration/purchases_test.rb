require 'test_helper'

class PurchasesTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
    @booster = purchase_types(:booster)
    @unlocker = purchase_types(:unlocker)
  end

  test 'should get index' do
    get '/api/purchases', params: { token: token }
    assert_response :success
  end

  test 'should purchase item' do
    assert_difference 'Purchase.count' do
      post '/api/purchases', params: { token: token, identifier: @unlocker.identifier }
    end
    assert_response :created
    assert @player.purchase_types.include?(@unlocker)
  end
end
