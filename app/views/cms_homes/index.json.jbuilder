json.array!(@cms_homes) do |cms_home|
  json.extract! cms_home, :id, :title, :url, :image, :content
  json.url cms_home_url(cms_home, format: :json)
end
