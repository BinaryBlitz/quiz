class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :player, index: true
      t.belongs_to :purchase_type, index: true

      t.timestamps null: false
    end
    add_foreign_key :purchases, :players
    add_foreign_key :purchases, :purchase_types
  end
end
