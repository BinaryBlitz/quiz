class RemoveXmppPasswordFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :xmpp_password, :string
  end
end
