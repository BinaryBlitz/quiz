class AddChallengeToLobbies < ActiveRecord::Migration
  def change
    add_column :lobbies, :challenge, :boolean, default: false
  end
end
