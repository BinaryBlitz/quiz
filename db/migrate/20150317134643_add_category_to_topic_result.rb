class AddCategoryToTopicResult < ActiveRecord::Migration
  def change
    add_reference :topic_results, :category, index: true
    add_foreign_key :topic_results, :categories
  end
end
