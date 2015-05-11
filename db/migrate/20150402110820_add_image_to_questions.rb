class AddImageToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :image_url
    add_column :questions, :image, :string
  end
end
