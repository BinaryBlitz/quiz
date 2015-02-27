class PlayersController < ApplicationController
  skip_before_filter :restrict_access, only: [:create, :authenticate, :authenticate_vk]

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

  def authenticate_vk
    token = params[:token]
    return unless token

    user = find_vk_player(token)

    unless @player
      name = "#{user.first_name} #{user.last_name}"
      @player = Player.create(name: name, vk_token: token, vk_id: user.uid)
    end

    render formats: :json, action: :authenticate, location: @player
  end

  private

  def player_params
    params.require(:player).permit(:name, :email, :password_digest, :points)
  end

  def find_vk_player(token)
    vk = VkontakteApi::Client.new(token)
    user = vk.users.get(fields: [:photo]).first
    @player = Player.find_by(vk_id: user.uid)
    user
  end
end
