json.top_rankings do json.array!(@rankings) do |player|
    json.extract! player, :id,  :name
    json.points player.points
  end
end

json.player_position @current_index

if @player_rankings
  json.player_rankings do
    json.array!(@player_rankings) do |player|
      json.extract! player, :id, :name
      json.points player.points
    end
  end
end
