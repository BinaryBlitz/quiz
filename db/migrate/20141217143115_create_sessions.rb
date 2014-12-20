class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :host_id, index: true
      t.integer :opponent_id, index: true
      t.boolean :online, default: false

      t.timestamps null: false
    end
  end
end
