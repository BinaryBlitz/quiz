# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  image_url  :string
#  bounty     :integer          default("1")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :topic

  validates :content, presence: true
  validates :topic, presence: true
  validates :bounty, numericality: { greater_than_or_equal_to: 0 }
end
