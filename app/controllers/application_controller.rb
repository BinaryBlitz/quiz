class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :restrict_access
  after_action :record_activity

  attr_reader :current_player
  helper_method :current_player

  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: { message: 'Invalid API Token' }, status: 401
      return
    end

    @current_player
  end

  def restrict_access_by_header
    return true if @current_player

    authenticate_with_http_token do |token|
      @current_player = Player.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if @current_player

    @current_player = Player.find_by_token(params[:token])
  end

  def record_activity
    current_player.update_column(:visited_at, Time.zone.now) if current_player
  end

  include Pundit

  def pundit_user
    current_player
  end

  rescue_from Pundit::NotAuthorizedError, with: :player_not_authorized

  include Pundit

  def pundit_user
    current_player
  end

  private

  def player_not_authorized
    head :forbidden
  end
end
