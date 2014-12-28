class Admin::DashboardController < ApplicationController
  def index
    @categories = Category.all
  end
end
