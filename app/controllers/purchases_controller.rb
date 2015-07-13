class PurchasesController < ApplicationController
  def index
    @purchase_types = PurchaseType.all
  end

  def create
    purchase_type = PurchaseType.find_by(identifier: params[:identifier])
    @purchase = current_player.purchases.build(purchase_type: purchase_type)

    if @purchase.save
      head :created
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end
end
