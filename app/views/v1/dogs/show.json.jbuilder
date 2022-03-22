json.data do
  json.message :successful
  json.dog do
    json.(@dog, :owner_id, :breed_id, :color, :name, :gender)
    json.images @dog.images do |image|
      json.filename image.filename
      json.url url_for(image)
    end
  end
end