json.array!(@leaves) do |leafe|
  json.extract! leafe, :id, :user_id, :start_at, :end_at, :kind, :status, :info, :image
  json.url leafe_url(leafe, format: :json)
end
