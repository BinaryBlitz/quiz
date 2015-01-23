class AddImeiToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :imei, :string
  end
end
