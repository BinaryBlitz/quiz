class CreatePurchaseTypes < ActiveRecord::Migration
  def change
    create_table :purchase_types do |t|
      t.string :identifier
      t.integer :multiplier
      t.belongs_to :topic, index: true

      t.timestamps null: false
    end
    add_foreign_key :purchase_types, :topics
  end
end
