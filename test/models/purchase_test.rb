# == Schema Information
#
# Table name: purchases
#
#  id               :integer          not null, primary key
#  player_id        :integer
#  purchase_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  expires_at       :datetime
#

require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  def setup
    @player = players(:foo)
    @purchase = purchases(:booster)
  end

  test 'invalid without purchase type' do
    @purchase.purchase_type = nil
    assert_raise NoMethodError do
      @purchase.invalid?
    end
  end

  test 'only unique purchases allowed' do
    assert_raise ActiveRecord::RecordInvalid do
      @player.purchases.create!(purchase_type: @purchase.purchase_type)
    end
  end
end
