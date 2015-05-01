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
#  wins          :integer          default(0)
#  draws         :integer          default(0)
#  losses        :integer          default(0)
#

class TopicResult < ActiveRecord::Base
  after_create :assign_category

  belongs_to :player
  belongs_to :topic
  belongs_to :category

  validates :topic, presence: true

  def add(session)
    add_points(session.player_points(player) * player.multiplier)
    update_score(session)
    save
  end

  def assign_category
    update!(category: topic.category)
  end

  private

  def older_than_week?
    updated_at < Time.zone.now.beginning_of_week
  end

  def add_points(total_points)
    if older_than_week?
      self.weekly_points = total_points
    else
      self.weekly_points += total_points
    end
    self.points += total_points
    self.count += 1
  end

  def update_score(session)
    if session.draw?
      self.draws += 1
    else
      if session.winner?(player)
        self.wins += 1
      else
        self.losses += 1
      end
    end
  end
end
