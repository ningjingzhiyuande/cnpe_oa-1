json.array!(@goods_applies) do |goods_apply|
  json.extract! goods_apply, :id, :good_id, :apply_num
  json.url goods_apply_url(goods_apply, format: :json)
end
