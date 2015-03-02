class CategoriesController < ApplicationController
  def index
    @categories = Category.all.includes(:topics)
    render formats: :json
  end

  def show
    @category = Category.find(params[:id])
    render formats: :json
  end
end
