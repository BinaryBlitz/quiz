class AddTopicToGameSessions < ActiveRecord::Migration
  def change
    add_reference :game_sessions, :topic, index: true
    add_foreign_key :game_sessions, :topics
  end
end
