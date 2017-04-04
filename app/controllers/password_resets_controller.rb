class PasswordResetsController < ApplicationController
  skip_before_action :restrict_access
  before_action :set_player, only: [:edit, :update]
  layout 'layouts/password_resets'

  def index
  end

  def new
  end

  def create
    player = Player.find_by(email: params[:email])
    player.send_password_reset if player

    respond_to do |format|
      if player
        format.json { head :created }
        format.html do
          redirect_to password_resets_path,
                      notice: 'Email with password reset instructions has been sent.'
        end
      else
        format.json { head :not_found }
        format.html { redirect_to password_resets_path, alert: 'User with this email not found.' }
      end
    end
  end

  def edit
  end

  def update
    if @player.password_reset_sent_at < 1.hour.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
      return
    end

    if @player.update(player_params) && password_present
      redirect_to password_resets_path, notice: 'Password has been reset.'
    else
      render :edit
    end
  end

  private

  def set_player
    @player = Player.find_by_password_reset_token!(params[:id])
  end

  def player_params
    params.require(:player).permit(:password, :password_confirmation)
  end

  def password_present
    player_params[:password].present? && player_params[:password_confirmation].present?
  end
end
