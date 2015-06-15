# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participation < ActiveRecord::Base
  belongs_to :player
  belongs_to :room

  validates :player, presence: true
  validates :room, presence: true, uniqueness: { scope: :player, message: 'already joined' }
end
