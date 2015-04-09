class AddExpiresAtToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :expires_at, :datetime
  end
end
