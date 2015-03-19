class AddEarlyWinsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :early_wins, :integer, default: 0
  end
end
