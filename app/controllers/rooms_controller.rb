class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :create]

  def index
    public_rooms = Room.recent.visible
    private_rooms = Room.visible_for(current_player).recent
    @rooms = public_rooms + private_rooms

  end

  def show
  end

  def create
    @room = current_player.owned_rooms.build(room_params)

    if @room.save
      render :show, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render :show, status: :ok, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    head :no_content
  end

  def join
    topic = Topic.find(params[:topic_id])
    participation = @room.participations.build(player: current_player, topic: topic)
    authorize participation, :create?

    if participation.save
      head :created
    else
      render json: participation.errors, status: :unprocessable_entity
    end
  end

  def leave
    @room.players.destroy(current_player)
    head :no_content
  end

  def start
    @room.start
    head :created
  end

  def finish
    @room.finish_as(current_player)
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:topic_id, :friends_only, :ready, :size)
  end
end
