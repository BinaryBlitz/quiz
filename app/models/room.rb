# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base
  belongs_to :player

  has_many :participations, dependent: :destroy
  has_many :players, through: :participations

  validates :player, presence: true
end
