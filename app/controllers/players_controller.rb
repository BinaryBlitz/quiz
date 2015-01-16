class PlayersController < ApplicationController
  before_action :restrict_access, except: [:create, :authenticate]
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

  # POST /players/authenticate
  def authenticate
    @player = Player.find_by(email: params[:email])

    if @player && @player.password_digest == params[:password_digest]
      render json: @player.api_key, only: :token
    else
      render json: { error: 'Invalid email/password combination' }
    end
  end

  private

    def player_params
      params.require(:player).permit(:name, :email, :password_digest, :points)
    end
end
