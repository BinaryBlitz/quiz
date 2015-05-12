class Admin::ImportsController < Admin::AdminController
  def new
  end

  def create
    file = params[:file].open
    import(file)
    redirect_to admin_topics_path, notice: 'Imported successfully.'
  rescue
    render :new, alert: 'Incorrect file format.'
  end

  private

  def import(f)
    category_name = f.gets
    category = Category.find_or_create_by(name: category_name)
    topic_name = f.gets
    topic = Topic.find_or_create_by(name: topic_name, category: category)

    # Questions are divided by two newlines
    questions = f.read.split("\n\n")

    questions.each do |question|
      content = question.split("\n")[0]
      answers = question.split("\n").drop(1)
      q = Question.new(content: content, topic: topic)
      answers.each_with_index do |answer, index|
        q.answers.build(content: answer, correct: index == 0)
      end
      q.save
    end
  end
end
