json.extract! category, :id, :name, :background_url, :banner_url
json.topics category.topics.where(visible: true) do |topic|
  json.partial! 'topics/topic', topic: topic
end
