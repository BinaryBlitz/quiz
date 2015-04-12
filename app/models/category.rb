# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  background :string
#  banner     :string
#

class Category < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  default_scope { order(created_at: :asc) }

  mount_uploader :background, BackgroundUploader
  mount_uploader :banner, BackgroundUploader

  validates :name, presence: true

  def to_s
    name
  end
end
