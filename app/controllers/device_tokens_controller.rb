class DeviceTokensController < ApplicationController
  before_action :set_device_token, only: [:destroy]

  # def create
  #   @device_token = current_player.device_tokens.build(device_token_params)
  #
  #   if @device_token.save
  #     head :created
  #   else
  #     head :unprocessable_entity
  #   end
  # end

  def create
    @device_token = current_player.device_tokens.build

    if params[:device_token].present?
      @device_token.token = params[:device_token][:token]
      @device_token.platform = params[:device_token][:platform]
    end

    # TODO: Deprecate
    @device_token.token = params[:push_token] if params[:push_token].present?
    @device_token.platform = 'ios' unless @device_token.platform.present?

    if @device_token.save
      head :created
    else
      render json: @device_token.errors, status: 422
    end
  end

  def delete
    @device_token.destroy
    head :no_content
  end

  private

  def set_device_token
    @device_token = DeviceToken.find_by!(token: params[:device_token])
  end

  def device_token_params
    params.require(:device_token).permit(:token, :platform)
  end
end
