# == Schema Information
#
# Table name: purchases
#
#  id               :integer          not null, primary key
#  player_id        :integer
#  purchase_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  def setup
    @player = players(:foo)
    @purchase = purchases(:booster)
  end

  test 'only unique purchases allowed' do
    assert_no_difference 'Purchase.count' do
      @player.purchases.create(purchase_type: @purchase.purchase_type)
    end
  end
end
