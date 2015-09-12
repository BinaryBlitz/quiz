json.extract! question, :id, :content, :image_url

json.answers question.answers do |answer|
  json.partial! 'answers/answer', answer: answer
end
