desc "Import questions from the text file"
task import: :environment do
  path = ENV["path"]
  next unless path

  f = File.open("lib/tasks/#{path}", 'r')
  # Category is the first line
  topic_name = f.gets
  topic = Topic.find_by(name: topic)

  unless topic
    topic = Topic.create(name: topic_name, category: Category.first)
  end

  # Questions are divided by two newlines
  questions = f.read.split("\n\n")

  questions.each do |question|
    content = question.split("\n")[0]
    answers = question.split("\n").drop(1)
    q = Question.create(content: content, topic: topic)

    answers.each_with_index do |answer, index|
      q.answers.create(content: answer, correct: index == 0)
    end
  end
end
