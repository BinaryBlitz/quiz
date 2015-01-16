class PlayersController < ApplicationController
  before_action :restrict_access, except: [:create]
  # GET /players
  def index
    @players = Player.all
    render formats: :json
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
    render formats: :json
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render :show, formats: :json, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      head :no_content
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    head :no_content
  end

  private

    def player_params
      params.require(:player).permit(:name, :email, :password_digest, :points)
    end
end
