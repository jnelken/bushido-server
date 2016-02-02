json.array! @users do |user|
  json.extract! user,
  :id,
  :username,
  :created_at,
  :updated_at,
  # add ELO/score
end
