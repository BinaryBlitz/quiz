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

class Purchase < ActiveRecord::Base
  before_create :set_expires_at

  belongs_to :player
  belongs_to :purchase_type

  validates :purchase_type, presence: true
  validates :player, presence: true
  validates :expires_at, presence: true
  validate :purchase_present

  scope :unexpired, -> { where('expires_at >= ? OR expires_at IS NULL', Time.zone.now) }

  def identifier
    purchase_type.identifier
  end

  private

  def set_expires_at
    self.expires_at = Time.zone.now + 10.days
  end

  def purchase_present
    if player.purchases.unexpired.find_by(purchase_type: purchase_type)
      errors.add(:player, 'has already purchased this item')
    end
  end
end
