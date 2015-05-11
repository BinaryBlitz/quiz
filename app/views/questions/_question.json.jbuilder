json.extract! question, :content, :image_url
# Use Answer partial
json.answers question.answers do |answer|
  json.partial! 'answers/answer', answer: answer
end
