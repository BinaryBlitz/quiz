class PurchasesController < ApplicationController
  def index
    @purchase_types = PurchaseType.all
  end

  def create
    purchase_type = PurchaseType.find_by(identifier: params[:identifier])
    unless purchase_type
      head :unprocessable_entity and return unless purchase_type
    end

    @purchase = Purchase.new(purchase_type: purchase_type, player: current_player)
    if @purchase.save
      head :created
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end
end
