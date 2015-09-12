class RemoveForeignKeysFromRooms < ActiveRecord::Migration
  def up
    remove_foreign_key :participations, :rooms
    remove_foreign_key :invites, :rooms
  end

  def down
    add_foreign_key :participations, :rooms
    add_foreign_key :invites, :rooms
  end
end
