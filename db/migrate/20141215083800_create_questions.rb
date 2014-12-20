class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :answers, array: true, default: []
      t.string :correct_answer

      t.timestamps null: false
    end
  end
end
