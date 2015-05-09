json.array!(@loan_goods) do |loan_good|
  json.extract! loan_good, :id, :good_id, :start_at, :end_at, :loan_info, :user_id, :status
  json.url loan_good_url(loan_good, format: :json)
end
