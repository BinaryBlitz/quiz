class RemoveForeignKeyForAnswers < ActiveRecord::Migration
  def up
    remove_foreign_key :answers, :questions
  end

  def down
    add_foreign_key :answers, :questions
  end
end
