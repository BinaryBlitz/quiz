class CreateRoomQuestions < ActiveRecord::Migration
  def change
    create_table :room_questions do |t|
      t.belongs_to :room_session, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
