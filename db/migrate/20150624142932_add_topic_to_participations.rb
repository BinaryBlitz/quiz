class AddTopicToParticipations < ActiveRecord::Migration
  def change
    add_reference :participations, :topic, index: true, foreign_key: true
  end
end
