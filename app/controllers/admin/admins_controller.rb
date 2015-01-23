class Admin::AdminsController < Admin::AdminController
  before_action :find_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all.order(id: :asc)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_path, notice: 'Admin was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      redirect_to admin_admins_path, notice: 'Admin was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @admin == Admin.first
      redirect_to admin_admins_path, alert: 'Unauthorized'
    else
      @admin.destroy
      redirect_to admin_admins_path, notice: 'Admin was successfully destroyed.'
    end
  end

  private

  def find_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :name, :password, :password_confirmation)
  end
end
