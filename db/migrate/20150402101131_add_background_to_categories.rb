class AddBackgroundToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :background, :string
    add_column :categories, :banner, :string
  end
end
