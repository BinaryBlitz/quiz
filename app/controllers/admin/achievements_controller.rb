class Admin::AchievementsController < Admin::AdminController
  before_action :set_achievement, only: [:show, :edit, :update]

  def index
    @achievements = Achievement.all
  end

  def show
  end

  def edit
  end

  def update
    if @achievement.update(achievement_params)
      redirect_to [:admin, @achievement], notice: 'Achievement was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_achievement
    @achievement = Achievement.find(params[:id])
  end

  def achievement_params
    params.require(:achievement).permit(:icon, :remove_icon, :icon_cache)
  end
end
