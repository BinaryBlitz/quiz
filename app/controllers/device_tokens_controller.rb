class DeviceTokensController < ApplicationController
  before_action :set_device_token, only: [:destroy]

  def create
    @device_token = current_player.device_tokens.build(device_token_params)

    if @device_token.save
      head :created
    else
      head :unprocessable_entity
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
