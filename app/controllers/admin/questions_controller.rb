class Admin::QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
    4.times { @question.answers.build }
  end

  def create
    @question = Question.new(question_params)
    @question.set_correct_answer

    if @question.save
      redirect_to admin_topic_path(@question.topic)
    else
      puts @question.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      @question.set_correct_answer
      redirect_to admin_topic_path(@question.topic)
    else
      render :edit
    end
  end

  def destroy
    #
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :topic_id, answers_attributes: [:id, :content, :correct, :_destroy])
  end
end
