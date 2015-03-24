class CategoriesController < ApplicationController
  def index
    @categories = Category.all.includes(:topics)
  end

  def show
    @category = Category.find(params[:id])
  end
end
