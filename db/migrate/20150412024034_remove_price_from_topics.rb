class RemovePriceFromTopics < ActiveRecord::Migration
  def self.up
    remove_column :topics, :price, :integer
  end

  def self.down
    add_column :topics, :price, :integer, default: 0
  end
end
