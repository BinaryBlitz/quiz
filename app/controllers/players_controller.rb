class PlayersController < ApplicationController
  skip_before_filter :restrict_access,
                     only: [:create, :authenticate, :authenticate_vk, :version]
  before_action :set_player, only: [:update, :destroy, :friends, :report, :flag_layer]

  def index
    @players = Player.all
  end

  def show
    @player = Player.includes(:topic_results).find(params[:id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render :authenticate, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
    if player_params[:avatar].present?
      @player.remove_vk_avatar!
    end

    if @player.update(player_params)
      render :show, status: :ok
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

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

    render :authenticate
  end

  # POST /players/authenticate_layer
  def authenticate_layer
    token = Layer::IdentityToken.new(current_player.id, params[:nonce])
    render json: { token: token }
  end

  # GET /players/search
  def search
    if params[:query].present? && params[:query].length >= 3
      @players = Player.search(params[:query])
    end
  end

  # TODO: GET?
  # GET /players/1/report
  def report
    @player.reports.create(message: params[:message])
    head :created
  end

  def version
    client = Semantic::Version.new(params[:version])
    server = Semantic::Version.new(API_VERSION)

    major = client.major < server.major

    if major || client.minor < server.minor
      render json: { update_available: true, major: major }
    else
      render json: { update_available: false }
    end
  end

  def flag_layer
    @player.update(layer_needs_authentication: true)
    head :ok
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(
      :username, :email, :password, :password_confirmation,
      :points, :avatar, :remove_avatar, :remove_vk_avatar, :nonce)
  end
end
