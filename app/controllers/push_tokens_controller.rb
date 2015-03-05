class PushTokensController < ApplicationController
  def create
    @token = PushToken.new(token: params[:push_token])
    @token.player = current_player

    if @token.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  def replace
    @token = PushToken.find_by_token(params[:old_token])

    if @token.update(token: params[:new_token])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @token = PushToken.find_by_token(params[:push_token])
    @token.destroy
    head :no_content
  end

  private

  def token_params
  end
end
