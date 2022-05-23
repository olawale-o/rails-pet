json.data do
  json.partial! 'shared/response_header', meta: {total_items: @dogs.size, next_page_no: @next_page_no, prev_page_no: @prev_page_no}, status: :successful
  json.dogs @dogs do |dog|
    json.(dog, :id, :owner, :breed_id, :color, :name, :gender, :pic_url)
    json.liked_by_me dog.liked_by?(current_user) if current_user
    json.images dog.images do |image|
      json.partial! 'shared/image', obj: image
    end
  end
end