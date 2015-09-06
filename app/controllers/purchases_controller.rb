class PurchasesController < ApplicationController
  def index
    @purchase_types = PurchaseType.all
  end

  def create
    purchase_type = PurchaseType.find_by(purchase_params)
    @purchase = current_player.purchases.find_or_initialize_by(purchase_type: purchase_type)

    if @purchase.save
      @purchase.touch(:updated_at)
      render :show, status: :created, location: @purchase
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.permit(:identifier)
  end
end
