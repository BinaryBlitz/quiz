json.extract! question, :id, :content, :image_url, :topic_id

json.answers question.answers do |answer|
  json.partial! 'answers/answer', answer: answer
end
