json.array!(@cms_departments) do |cms_department|
  json.extract! cms_department, :id, :title, :content, :image, :kind
  json.url cms_department_url(cms_department, format: :json)
end
