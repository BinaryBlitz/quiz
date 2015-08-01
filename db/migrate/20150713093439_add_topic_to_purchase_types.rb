class AddTopicToPurchaseTypes < ActiveRecord::Migration
  def change
    remove_column :purchase_types, :topic_id, :integer
    add_column :purchase_types, :topic, :boolean
  end
end
