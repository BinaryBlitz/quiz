class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to [:admin, @category], notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @category == Category.first
      redirect_to admin_categories_path, alert: 'You cannot delete the first category.'
    else
      @category.destroy
      redirect_to admin_path, notice: 'Category was successfully destroyed.'
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
