json.data do
  json.message :successful
  if @dog_photos
    json.photos @dog_photos do |image|
      json.partial! 'shared/image', obj: image
    end
  end

  if @dog
    json. dog do
      (@dog, :id, :breed_id, :color, :name, :gender, :pic_url)
    end
  end
end
