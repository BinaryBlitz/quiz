# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

class Room < ActiveRecord::Base
  belongs_to :player
  belongs_to :topic

  has_one :room_session, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :players, through: :participations

  validates :player, presence: true
  validates :topic, presence: true

  def join(new_player, selected_topic)
    participations.create(player: new_player, topic: selected_topic)
  end

  def start
    create_room_session
    # Push session
  end
end
