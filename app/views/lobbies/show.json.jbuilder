json.extract! @lobby, :id, :topic_id, :player_id, :query_count, :challenge
json.fact Fact.random
