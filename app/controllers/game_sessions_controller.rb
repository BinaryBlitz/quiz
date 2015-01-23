class GameSessionsController < ApplicationController
  # GET /game_sessions
  def index
    @game_sessions = GameSession.all
    render formats: :json
  end

  # GET /game_sessions/1
  def show
    @game_session = GameSession.find(params[:id])
    render formats: :json
  end

  # POST /game_sessions
  def create
    @game_session = GameSession.new(game_session_params)
    @game_session.generate

    if @game_session.save
      render :show, formats: :json, status: :created, location: @game_session
    else
      render json: @game_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /game_sessions/1
  def update
    @game_session = GameSession.find(params[:id])

    if @game_session.update(game_session_params)
      head :no_content
    else
      render json: @game_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game_sessions/1
  def destroy
    @game_session = GameSession.find(params[:id])
    @game_session.destroy

    head :no_content
  end

  # GET /game_sessions/find
  def find
  end

  private

  def game_session_params
    params.require(:game_session).permit(:host_id, :opponent_id, :topic_id)
  end
end
