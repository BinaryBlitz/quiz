# == Schema Information
#
# Table name: achievements
#
#  id         :integer          not null, primary key
#  badge_id   :integer
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Achievement < ActiveRecord::Base
  validates :badge_id, uniqueness: true

  mount_uploader :icon, IconUploader

  def self.icon_url_for(badge)
    achievement = find_by(badge_id: badge.id)
    achievement.try(:icon_url)
  end
end
