class TopicExporter
  def initialize(topic)
    @topic = topic
  end

  def export(&block)
    create_file
    write_topic
    write_questions
    @file.close

    block.call @file.path
  end

  private

  def create_file
    temp_dir = Dir.mktmpdir
    @file = File.open("#{temp_dir}/topic_#{@topic.id}.txt", 'w+')
  end

  def write_topic
    @file.puts(@topic.category.name)
    @file.puts(@topic.name)
    @file.puts
  end

  def write_questions
    @topic.questions.each do |question|
      @file.puts(question.content)
      question.answers.order(correct: :desc).each do |answer|
        @file.puts(answer.content)
      end
      @file.puts
    end
  end
end
