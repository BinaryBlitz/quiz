class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :points, default: 0

      t.timestamps null: false
    end
    add_index :players, :email, unique: true
  end
end
