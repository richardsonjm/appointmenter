json.array!(@users) do |user|
  json.extract! user, :id, :email, :first_name, :last_name, :street, :city, :state, :zip
  json.url user_url(user, format: :json)
end
