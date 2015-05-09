json.array!(@cms_dangquns) do |cms_dangqun|
  json.extract! cms_dangqun, :id, :title, :document
  json.url cms_dangqun_url(cms_dangqun, format: :json)
end
