class PlayersController < ApplicationController
  skip_before_filter :restrict_access, only: [:create, :authenticate, :authenticate_vk]
  before_action :set_player, only: [:show, :update, :destroy, :friends]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show
    @is_friend = current_player.friends.include?(@player)
    @score = current_player.score_against(@player)
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render status: :created
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      head :no_content
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy

    head :no_content
  end

  # GET /players/1/friends
  def friends
    @friends = @player.friends
  end

  # POST /players/authenticate
  def authenticate
    @player = Player.find_by(email: params[:email])

    unless @player && @player.password_digest == params[:password_digest]
      render json: { error: 'Invalid email/password combination' }, status: :unauthorized
      return
    end
  end

  def authenticate_vk
    return unless params[:token].present?
    vk = VkontakteApi::Client.new(params[:token])
    @player = Player.find_or_create_from_vk(vk)

    render action: :authenticate, location: @player
  end

  def search
    @players = Player.where(name: params[:query])
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :email, :password_digest, :points, :avatar)
  end
end
