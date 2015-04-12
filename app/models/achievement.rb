# == Schema Information
#
# Table name: achievements
#
#  id         :integer          not null, primary key
#  badge_id   :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Achievement < ActiveRecord::Base
  validates :badge_id, uniqueness: true

  default_scope -> { order(id: :asc) }

  mount_uploader :icon, IconUploader
end
