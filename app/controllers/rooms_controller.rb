class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy, :join, :leave]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # POST /rooms
  def create
    @room = current_player.owned_rooms.build(room_params)

    if @room.save
      render :show, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      render :show, status: :ok, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  def destroy
    @room.destroy
    head :no_content
  end

  def join
    topic = Topic.find_by(id: params[:topic_id])
    participation = current_player.participations.build(room: @room, topic: topic)

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
    # Create room session
    # Push game start event
    # Push room session
  end

  def close
    # Add points
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:topic_id)
  end
end
