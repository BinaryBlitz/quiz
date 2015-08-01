class AddVisitedAtToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :visited_at, :timestamp
  end
end
