class AddReportsCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :reports_count, :integer, default: 0
  end
end
