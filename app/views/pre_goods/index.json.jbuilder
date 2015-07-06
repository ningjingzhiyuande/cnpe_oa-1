json.array!(@pre_goods) do |pre_good|
  json.extract! pre_good, :id, :name, :num, :price, :is_consume
  json.url pre_good_url(pre_good, format: :json)
end
