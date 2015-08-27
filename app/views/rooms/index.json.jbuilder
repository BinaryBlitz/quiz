json.array! @rooms do |room|
  json.partial! 'rooms/room', room: room if room.visible_for?(current_player)
end
