class AddPointsAndWeeklyPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :points, :integer, default: 0
    add_column :players, :weekly_points, :integer, default: 0
  end
end
