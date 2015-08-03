class AddCreatorIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :creator_id, :integer
  end
end
