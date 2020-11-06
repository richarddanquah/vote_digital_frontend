json.extract! transaction, :id, :merchant_id, :trans_id, :customer_number, :customer_netowrk, :trans_type, :amount, :reference, :pay_status, :award_id, :category_id, :nominee_id, :techo_msg, :payment_types, :card_name, :card_email, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
