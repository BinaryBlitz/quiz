class AddXmppPasswordToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :xmpp_password, :string
  end
end
