json.array! @friends do |friend|
  json.partial! 'players/player', player: friend
end
