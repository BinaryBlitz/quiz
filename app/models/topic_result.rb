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
#

class TopicResult < ActiveRecord::Base
  belongs_to :player
  belongs_to :topic

  def add(result)
    update!(points: points + result)
  end
end
