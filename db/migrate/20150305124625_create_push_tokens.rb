class CreatePushTokens < ActiveRecord::Migration
  def change
    create_table :push_tokens do |t|
      t.string :token
      t.boolean :android, default: false
      t.belongs_to :player, index: true

      t.timestamps null: false
    end
    add_foreign_key :push_tokens, :players
    add_index :push_tokens, :token
  end
end
