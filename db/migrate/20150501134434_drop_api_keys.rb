class DropApiKeys < ActiveRecord::Migration
  def change
    drop_table :api_keys
    add_column :players, :token, :string
  end
end