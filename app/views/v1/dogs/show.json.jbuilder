json.data do
  json.message :successful
  json.dog do
    json.(@dog, :id, :owner_id, :color, :name, :gender, :description, :weight)
    json.breed(@dog.breed.name)
    json.images @dog.images do |image|
      json.partial! 'shared/image', obj: image
    end
  end
end
