class PushTokensController < ApplicationController
  def create
    @token = PushToken.new(token: params[:push_token])
    @token.player = current_player
    @token.android = (params[:android] == 'true')

    if @token.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  def replace
    @token = PushToken.find_by_token(params[:old_token])

    if @token && @token.update(token: params[:new_token])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def delete
    @token = PushToken.find_by(token: params[:push_token])

    if @token
      @token.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def token_params
  end
end
