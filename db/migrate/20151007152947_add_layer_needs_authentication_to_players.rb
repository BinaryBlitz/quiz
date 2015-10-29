class AddLayerNeedsAuthenticationToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :layer_needs_authentication, :boolean
  end
end
