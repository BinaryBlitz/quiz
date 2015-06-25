class CreateRoomAnswers < ActiveRecord::Migration
  def change
    create_table :room_answers do |t|
      t.belongs_to :room_question, index: true, foreign_key: true
      t.belongs_to :participation, index: true, foreign_key: true
      t.integer :time, default: 0
      t.belongs_to :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
