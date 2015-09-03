# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string
#  creator_id :integer
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :creator, class_name: 'Player'
  belongs_to :player

  validates :content, presence: true
  validates :creator, presence: true
  validates :player, presence: true

  def post
    notify
    save
  end

  private

  def notify
    Notifier.new(player, content, as_json).push
  end
end
