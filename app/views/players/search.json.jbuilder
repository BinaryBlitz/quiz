json.cache! @players do
  json.partial! 'player', collection: @players, as: :player
end
