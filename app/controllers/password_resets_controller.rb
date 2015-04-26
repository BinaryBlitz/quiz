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
    redirect_to password_resets_path, notice: 'Email sent with password reset instructions.'
  end

  def edit
  end

  def update
    if @player.password_reset_sent_at < 1.hour.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
      return
    end

    if @player.update_password(params[:player][:password], params[:player][:password_confirmation])
      redirect_to password_resets_path, notice: 'Password has been reset.'
    else
      render :edit
    end
  end

  private

  def set_player
    @player = Player.find_by_password_reset_token!(params[:id])
  end
end
