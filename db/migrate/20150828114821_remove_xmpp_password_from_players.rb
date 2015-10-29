class RemoveXmppPasswordFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :xmpp_password, :string
  end

  def down
    add_column :players, :xmpp_password, :string
  end
end
