# == Schema Information
#
# Table name: purchase_types
#
#  id         :integer          not null, primary key
#  identifier :string
#  multiplier :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PurchaseType < ActiveRecord::Base
  belongs_to :topic
  has_many :purchases, dependent: :destroy

  validates :identifier, presence: true
  validates :identifier, uniqueness: true

  def booster?
    multiplier && !topic
  end

  def topic_unlocker?
    !multiplier && topic
  end
end
