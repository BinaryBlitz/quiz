json.rankings do
  json.array!(@rankings) do |player|
    json.partial! 'player', player: player, topic: @topic
  end
end

json.position @position if @position

if @player_rankings
  json.player_rankings do
    json.array!(@player_rankings) do |player|
      json.partial! 'player', player: player, topic: @topic
    end
  end
end
