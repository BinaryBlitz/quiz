class CreateSessionQuestions < ActiveRecord::Migration
  def change
    create_table :session_questions do |t|
      t.references :session, index: true
      t.references :question, index: true
      t.integer :host_answer_id
      t.integer :opponent_answer
      t.integer :host_time, default: 0
      t.integer :opponent_time, default: 0

      t.timestamps null: false
    end
    add_foreign_key :session_questions, :sessions
    add_foreign_key :session_questions, :questions
  end
end
