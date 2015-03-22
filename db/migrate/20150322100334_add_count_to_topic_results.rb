class AddCountToTopicResults < ActiveRecord::Migration
  def change
    add_column :topic_results, :count, :integer, default: 0
  end
end
