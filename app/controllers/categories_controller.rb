class CategoriesController < ApplicationController
  before_action :restrict_access

  def index
    @categories = Category.all
    render formats: :json
  end

  def show
    @category = Category.find(params[:id])
    render formats: :json
  end
end
