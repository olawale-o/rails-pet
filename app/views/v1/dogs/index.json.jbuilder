json.data do
  json.message :successful
  json.dogs @dogs do |dog|
    json.dog dog
    json.images do |image|
      json.filename image.filename
      json.url url_for(image)
    end
  end
end