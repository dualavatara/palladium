json.array!(@users) do |user|
  json.extract! user, :id, :name, :login, :passwd
  json.url user_url(user, format: :json)
end
