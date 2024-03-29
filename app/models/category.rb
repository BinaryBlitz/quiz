# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  background :string
#  banner     :string
#

class Category < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :topic_results, dependent: :destroy

  mount_uploader :background, BackgroundUploader
  mount_uploader :banner, BackgroundUploader

  validates :name, presence: true
end
