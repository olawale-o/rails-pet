json.data do
  json.message :successful
  if @my_dogs
    json.owner do
      json.(@user, :id, :dogs_count, :username)
      json.dogs @my_dogs do |dog|
        json.(dog, :id, :pic_url, :breed_id, :color, :name, :gender)
        json.images dog.images do |image|
          json.partial! 'shared/image', obj: image
        end
      end
    end
  else
    json.dogs @breed_dogs do |dog|
      json.(dog, :name, :color, :pic_url)
    end
  end
end