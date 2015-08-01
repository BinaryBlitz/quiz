class RemoveExpiresAtFromPurchases < ActiveRecord::Migration
  def change
    remove_column :purchases, :expires_at, :string
  end
end
