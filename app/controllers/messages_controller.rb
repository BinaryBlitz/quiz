class MessagesController < ApplicationController
  def index
    from = Player.find(params[:player_id])
    @messages = current_player.unread_messages.where(creator: from)
  end

  def create
    @message = current_player.created_messages.build(message_params)

    if @message.post
      head :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :player_id)
  end
end
