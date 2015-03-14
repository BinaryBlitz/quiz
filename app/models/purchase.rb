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
  validates :player_id, uniqueness: { scope: :purchase_type_id }
end
