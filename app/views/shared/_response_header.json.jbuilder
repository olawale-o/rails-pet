json.message status
if local_variables.include?(:meta)
  json.result_metadata do
    json.total_items meta[:total_items]
    json.next_page_no meta[:next_page_no] if meta[:next_page_no]
    json.prev_page_no meta[:prev_page_no] if meta[:prev_page_no]
  end
end
