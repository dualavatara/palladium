json.array!(@users) do |user|
  json.id user.id().to_s
  json.name user.name
end