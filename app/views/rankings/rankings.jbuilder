json.rankings do
  json.array!(@rankings) do |player|
    json.cache! "rankings-#{@topic.try(:id)}-#{weekly?}/#{player.id}", expires_in: 1.hour do
      json.partial! 'player', player: player
    end
  end
end

json.position @position if @position

if @player_rankings
  json.player_rankings do
    json.array!(@player_rankings) do |player|
      json.cache! "rankings-#{@topic.try(:id)}-#{weekly?}/#{player.id}", expires_in: 1.hour do
        json.partial! 'player', player: player
      end
    end
  end
end
