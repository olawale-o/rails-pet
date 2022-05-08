json.data do
  json.message :successful
  json.photos @dog_photos do |image|
    json.partial! 'shared/image', obj: image
  end
end
