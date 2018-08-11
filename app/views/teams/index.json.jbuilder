json.array!(@teams) do |team|
  json.extract! team, :id, :student_id, :name
  json.url team_url(team, format: :json)
end
