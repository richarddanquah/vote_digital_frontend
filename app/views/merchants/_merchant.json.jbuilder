json.extract! merchant, :id, :name, :description, :user_id, :address, :contact_number, :contact_email, :status, :created_at, :updated_at
json.url merchant_url(merchant, format: :json)
