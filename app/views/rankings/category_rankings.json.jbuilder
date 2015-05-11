json.rankings do
  json.array!(@rankings) do |player|
    json.extract! player, :id, :name, :avatar_url
    json.points player.total_points
  end
end

json.position @position if @position

if @player_rankings
  json.player_rankings do
    json.array!(@player_rankings) do |player|
      json.extract! player, :id, :name, :avatar_url
      json.points player.total_points
    end
  end
end
