class AchievementsController < ApplicationController
  def index
    @achievements = Merit::Badge.all
    @player_achievements = current_player.badges
  end
end
