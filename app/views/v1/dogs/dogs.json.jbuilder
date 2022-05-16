json.data do
  json.message :successful
  json.dogs @dogs do |dog|
    json.(dog, :id, :owner, :breed_id, :color, :name, :gender, :pic_url)
    json.images dog.images do |image|
      json.partial! 'shared/image', obj: image
    end
  end
end