class CategoriesController < ApplicationController
  def index
    @categories = Category.all.includes(:topics).where('topics.visible': true)
  end

  def show
    @category = Category.find(params[:id])
  end
end
