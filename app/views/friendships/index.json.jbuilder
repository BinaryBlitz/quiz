json.array! @friends do |friend|
  json.extract! friend, :id, :name
end
