class Admin::DashboardController < Admin::AdminController
  def index
    @categories = Category.all
    @topics = Topic.all
    @achievements = Achievement.all
    @facts = Fact.all
    @purchase_types = PurchaseType.all
  end

  def manage
    @admins = Admin.all
  end
end
