# == Schema Information
#
# Table name: topic_results
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  topic_id      :integer
#  points        :integer          default(0)
#  weekly_points :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  count         :integer          default(0)
#

class TopicResult < ActiveRecord::Base
  after_create :assign_category

  belongs_to :player
  belongs_to :topic
  belongs_to :category

  validates :topic, presence: true

  def add(result)
    update!(points: points + result, count: count + 1)
    if updated_at < DateTime.now.beginning_of_week
      update!(weekly_points: result)
    else
      update!(weekly_points: weekly_points + result)
    end
  end

  def assign_category
    update!(category: topic.category)
  end
end
