json.extract! contact, :id, :fullname, :email, :subject, :message, :status, :created_at, :updated_at
json.url contact_url(contact, format: :json)
