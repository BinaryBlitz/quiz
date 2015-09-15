# == Schema Information
#
# Table name: purchase_types
#
#  id         :integer          not null, primary key
#  identifier :string
#  multiplier :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic      :boolean
#

class PurchaseType < ActiveRecord::Base
  has_many :purchases, dependent: :destroy

  validates :identifier, presence: true, uniqueness: true

  scope :multipliers, -> { where.not(multiplier: nil) }
  scope :unlockers, -> { where(topic: true) }

  def booster?
    multiplier && !topic
  end

  def topic_unlocker?
    !multiplier && topic
  end
end
