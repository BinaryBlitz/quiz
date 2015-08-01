class Admin::PurchaseTypesController < Admin::AdminController
  before_action :set_purchase_type, except: [:index, :new, :create]

  def index
    @purchase_types = PurchaseType.all
  end

  def show
  end

  def new
    @purchase_type = PurchaseType.new
  end

  def create
    @purchase_type = PurchaseType.new(purchase_type_params)

    if @purchase_type.save
      redirect_to admin_purchase_types_path, notice: 'Purchase type was created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @purchase_type.update(purchase_type_params)
      redirect_to admin_purchase_types_path, notice: 'Purchase type was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @purchase_type.destroy
    redirect_to admin_purchase_types_path, notice: 'Purchase type was destroyed successfully.'
  end

  private

  def purchase_type_params
    params.require(:purchase_type).permit(:identifier, :multiplier, :topic)
  end

  def set_purchase_type

    @purchase_type = PurchaseType.find(params[:id])
  end
end
