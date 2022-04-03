json.data do
  json.message :successful
  json.breeds @breeds do |breed|
    json.(breed, :id, :name)
  end
end