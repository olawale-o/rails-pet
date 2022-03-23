json.data do
  json.message :successful
  json.dogs @dogs do |dog|
    json.(dog, :id, :owner_id, :breed_id, :color, :name, :gender)
    json.images dog.images do |image|
      json.partial! 'shared/image', obj: image
    end
  end
end