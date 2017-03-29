class RemoveLayerNeedsAuthenticationFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :layer_needs_authentication, :boolean
  end
end
