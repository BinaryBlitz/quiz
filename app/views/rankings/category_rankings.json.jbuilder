json.rankings do
  json.array!(@rankings) do |player|
    json.partial! 'player_with_category', player: player, category: @category, weekly: @weekly
  end
end

json.position @position if @position

if @player_rankings
  json.player_rankings do
    json.array!(@player_rankings) do |player|
      json.partial! 'player', player: player, category: @category, weekly: @weekly
    end
  end
end
