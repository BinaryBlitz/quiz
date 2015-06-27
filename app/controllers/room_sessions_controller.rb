class RoomSessionsController < ApplicationController
  before_action :set_room_session, only: [:show]

  def show
  end

  private

  def set_room_session
    @room_session = RoomSession.find(params[:id])
  end
end
