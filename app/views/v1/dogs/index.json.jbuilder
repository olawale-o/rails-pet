json.data do
  json.partial! 'shared/response_header', status: :successful
  if @my_dogs
    json.owner do
      json.(@user, :id, :dogs_count, :username)
      json.dogs @my_dogs do |dog|
        json.(dog, :id, :pic_url, :breed_id, :color, :name, :gender)
        json.liked_by_me dog.liked_by?(current_user) if current_user
        json.likes dog.likes.size
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