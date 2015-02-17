class PlayersController < ApplicationController
  skip_before_filter :restrict_access, only: [:create, :authenticate]

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
      render formats: :json, status: :created
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
      render formats: :json
    else
      render json: { error: 'Invalid email/password combination' }, status: :unauthorized
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :email, :password_digest, :points)
  end
end
