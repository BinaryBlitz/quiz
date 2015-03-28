class AchievementsController < ApplicationController
  def index
    @achievements = Merit::Badge.all
  end
end
