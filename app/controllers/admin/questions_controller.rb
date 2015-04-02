class Admin::QuestionsController < Admin::AdminController
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
      redirect_to [:admin, @question.topic], notice: 'Question was successfully created.'
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
      redirect_to [:admin, @question.topic], notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to [:admin, @question.topic], notice: 'Question was successfully destroyed.'
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :content, :topic_id, :image, :remove_image,
      answers_attributes: [:id, :content, :correct, :_destroy])
  end
end
