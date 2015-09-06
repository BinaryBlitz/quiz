json.cache! @categories do
  json.partial! 'category', collection: @categories, as: :category
end
