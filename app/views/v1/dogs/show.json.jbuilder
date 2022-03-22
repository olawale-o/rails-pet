json.data do
  json.message :successful
  json.dog @dog
  json.images @dog.images do |image|
    json.filename image.filename
    json.url url_for(image)
  end
end