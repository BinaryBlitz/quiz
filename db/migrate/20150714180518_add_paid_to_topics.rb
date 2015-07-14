class AddPaidToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :paid, :boolean, default: false
  end
end
