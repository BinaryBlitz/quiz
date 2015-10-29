class RoomMessagesController < ApplicationController
  def create
    content = params[:content]
    room = current_player.rooms.find(params[:room_id])

    if content && room
      message = { content: content, player_id: current_player.id }
      Pusher.trigger("room-#{room.id}", 'room-message', content: message)
      head :ok
    else
      render json: { room_message: 'is invalid' }, status: 422
    end
  end
end
