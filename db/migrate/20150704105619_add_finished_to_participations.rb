class AddFinishedToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :ready, :boolean, default: false
    add_column :participations, :finished, :boolean, default: false
  end
end
