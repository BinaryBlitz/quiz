class RemoveForeignKeyForAnswers < ActiveRecord::Migration
  def change
    remove_foreign_key :answers, :questions
  end
end
