class AddScoresToTopicResults < ActiveRecord::Migration
  def change
    add_column :topic_results, :wins, :integer, default: 0
    add_column :topic_results, :draws, :integer, default: 0
    add_column :topic_results, :losses, :integer, default: 0
  end
end
