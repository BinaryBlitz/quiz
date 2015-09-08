class RenameGameSessionQuestionsToGameQuestions < ActiveRecord::Migration
  def change
    rename_table :game_session_questions, :game_questions
  end
end
