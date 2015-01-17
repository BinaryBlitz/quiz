json.extract! category, :id, :name
json.topics category.topics do |topic|
  json.partial! 'topics/topic', topic: topic
end
