class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :image_url
      t.integer :bounty, default: 1

      t.timestamps null: false
    end
  end
end
