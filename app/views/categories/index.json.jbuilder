json.array!(@categories) do |category|
  json.extract! category, :id, :kind, :item_num, :name, :info, :position, :status
  json.url category_url(category, format: :json)
end
