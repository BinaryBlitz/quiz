class PurchasesController < ApplicationController
  def index
    @identifiers = current_player.purchases.map { |p| p.purchase_type.identifier }
    render formats: :json
  end

  def available
    @available = PurchaseType.all
    render formats: :json
  end

  def create
    purchase_type = PurchaseType.find_by(identifier: params[:identifier])
    unless purchase_type
      render json: 'Purchase identifier not found.' and return unless purchase_type
    end

    @purchase = Purchase.new(purchase_type: purchase_type, player: current_player)
    if @purchase.save
      head :created
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end
end
