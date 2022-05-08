json.data do
  json.message :successful
  if @my_dogs
    json.owner do
      json.(current_user, :id, :dogs_count, :username)
      json.dogs @my_dogs do |dog|
        json.(dog, :id, :breed_id, :color, :name, :gender)
        json.images dog.images do |image|
          json.partial! 'shared/image', obj: image
        end
      end
    end
  else
    json.dogs @breed_dogs do |dog|
      json.(dog, :name, :color)
    end
  end
end