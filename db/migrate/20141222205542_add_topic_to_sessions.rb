class AddTopicToSessions < ActiveRecord::Migration
  def change
    add_reference :sessions, :topic, index: true
    add_foreign_key :sessions, :topics
  end
end
