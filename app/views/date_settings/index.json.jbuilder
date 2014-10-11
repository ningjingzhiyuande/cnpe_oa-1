json.array!(@date_settings) do |date_setting|
  json.extract! date_setting, :id, :year, :is_work, :data, :user_id
  json.url date_setting_url(date_setting, format: :json)
end
