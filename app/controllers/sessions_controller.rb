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
    generate_session

    if @session.save
      render json: @session.to_json(
        include: { session_questions: { include: { question: { include: :answers }} }}), status: :created, location: @session
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
    params.require(:session).permit(:host_id, :opponent_id, :topic_id)
  end

  def generate_session
    # Offline only for now
    @session.offline = true

    6.times do
      # Avoid repetitions
      begin
        sq = SessionQuestion.create(question: Question.where(topic: @session.topic).sample)
      end while @session.questions.include?(sq.question)
      # Random answer and time
      sq.opponent_answer = sq.question.answers.sample
      sq.opponent_time = (2..6).to_a.sample

      @session.session_questions << sq
    end
  end
end
