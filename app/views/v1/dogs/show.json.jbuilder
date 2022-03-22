json.data do
  json.message :successful
  json.dog do
    json.(@dog, :owner_id, :breed_id, :color, :name, :gender)
    json.images @dog.images do |image|
      json.partial! 'shared/image', obj: image
    end
  end
end