json.array! @rooms do |room|
  if room.visible_for?(current_player)
    json.partial! 'rooms/room', room: room
  end
end
