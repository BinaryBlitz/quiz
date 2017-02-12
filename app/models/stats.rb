# == Schema Information
#
# Table name: stats
#
#  id            :integer          not null, primary key
#  days_in_a_row :integer          default(0)
#  played_at     :date
#  player_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  early_wins    :integer          default(0)
#

class Stats < ActiveRecord::Base
  belongs_to :player

  def increment_consecutive_days
    today = Date.today
    self.days_in_a_row = days_in_a_row + 1 if played_at == today - 1
    self.played_at = today
    save!
  end

  def increment_early_winner(game_session)
    update!(early_wins: early_wins + 1) if game_session.early_winner?(player)
  end
end
