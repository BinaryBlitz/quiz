class Admin::DashboardController < Admin::AdminController
  def index
    @categories = Category.all
    @topics = Topic.all
  end

  def manage
    @admins = Admin.all
  end
end
