class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.belongs_to :player, index: true
      t.belongs_to :topic, index: true
      t.text :content
      t.text :answers, array: true

      t.timestamps null: false
    end
  end
end
