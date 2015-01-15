class Admin::DashboardController < Admin::AdminController
  def index
    @categories = Category.all
    @topics = Topic.all
  end
end
