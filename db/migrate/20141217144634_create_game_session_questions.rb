class CreateGameSessionQuestions < ActiveRecord::Migration
  def change
    create_table :game_session_questions do |t|
      t.references :game_session, index: true
      t.references :question, index: true
      t.integer :host_answer_id
      t.integer :opponent_answer_id
      t.integer :host_time, default: 0
      t.integer :opponent_time, default: 0

      t.timestamps null: false
    end
    add_foreign_key :game_session_questions, :game_sessions
    add_foreign_key :game_session_questions, :questions
  end
end
