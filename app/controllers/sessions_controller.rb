class SessionsController < ApplicationController
  # GET /sessions
  def index
    @sessions = Session.all
    render json: @sessions
  end

  # GET /sessions/1
  def show
    @session = Session.find(params[:id])
    render json: @session
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      render json: @session, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sessions/1
  def update
    @session = Session.find(params[:id])

    if @session.update(session_params)
      head :no_content
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    head :no_content
  end

  private

  def session_params
    params.require(:session).permit(:player_id, :opponent_id)
  end
end
