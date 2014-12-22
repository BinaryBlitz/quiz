class AddOfflineToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :offline, :boolean, default: false
  end
end
