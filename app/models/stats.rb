class Stats < ActiveRecord::Base
  belongs_to :player

  def increment_consecutive_days
    update!(days_in_a_row: days_in_a_row + 1) if played_at == Date.today - 1
    update!(played_at: Date.today)
  end
end
