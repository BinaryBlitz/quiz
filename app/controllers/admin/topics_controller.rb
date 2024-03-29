class Admin::TopicsController < Admin::AdminController
  before_action :find_topic, only: [:show, :edit, :update, :destroy, :export]

  def index
    @topics = Topic.includes(:category).order('categories.name ASC').page(params[:page])
  end

  def show
    @questions = Question.where(topic: @topic) #.page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to [:admin, @topic], notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to [:admin, @topic], notice: 'Тема успешно обновлена.'
    else
      render :new
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_topics_path, notice: 'Topic was successfully destroyed.'
  end

  def export
    TopicExporter.new(@topic).export do |path|
      file = File.read(path)
      send_data file, filename: 'export.txt', status: :ok
    end
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(
      :name, :visible, :paid, :expires_at, :featured,
      :category_id, purchase_type_attributes: [:id, :identifier])
  end
end
