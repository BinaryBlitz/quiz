class PlayersController < ApplicationController
  skip_before_filter :restrict_access,
                     only: [:create, :authenticate, :authenticate_vk, :username_availability]
  before_action :set_player, only: [:show, :update, :destroy, :friends, :report]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show
    @is_friend = current_player.friends.include?(@player)
    @score = current_player.score_against(@player)
    @total_score = @player.total_score
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
    @player = Player.find_by(username: params[:username])

    if @player.try(:authenticate, params[:password])
      render :authenticate
    else
      render json: { error: 'Invalid username / password combination' }, status: :unauthorized
    end
  end

  # POST /players/authenticate_vk
  def authenticate_vk
    return unless params[:token].present?
    vk = VkontakteApi::Client.new(params[:token])
    @player = Player.find_or_create_from_vk(vk)

    render :authenticate, location: @player
  end

  def search
    @players = Player.search(params[:query])
  end

  # GET /players/1/report
  def report
    @player.reports.create(message: params[:message])
    head :created
  end

  def username_availability
    @available = Player.find_by(username: params[:username]).nil?
    render json: { available: @available }
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(
      :name, :username, :email, :password, :password_confirmation, :points, :avatar
    )
  end
end
