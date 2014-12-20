class AddTopicToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :topic, index: true
    add_foreign_key :questions, :topics
  end
end
