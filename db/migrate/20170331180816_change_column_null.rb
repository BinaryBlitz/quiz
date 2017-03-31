class ChangeColumnNull < ActiveRecord::Migration
  def change
    change_column_null :facts, :content, false
    change_column_null :categories, :name, false
    change_column_null :topics, :name, false
    change_column_null :questions, :content, false
    change_column_null :reports, :message, false
  end
end
