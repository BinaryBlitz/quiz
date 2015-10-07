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

class Purchase < ActiveRecord::Base
  belongs_to :player
  belongs_to :purchase_type

  validates :purchase_type, presence: true
  validates :player, presence: true

  DAYS_VALID = 10

  scope :unexpired, -> { where('purchases.updated_at >= ?', Time.zone.now - DAYS_VALID.days) }
  scope :multipliers, -> { joins(:purchase_type).where.not('purchase_types.multiplier' => nil) }

  def identifier
    purchase_type.identifier
  end

  def expired?
    updated_at < Time.zone.now - DAYS_VALID.days
  end

  def expires_at
    updated_at + DAYS_VALID.days
  end
end
