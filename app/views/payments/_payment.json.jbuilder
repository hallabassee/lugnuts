json.extract! payment, :id, :customerNumber, :checkNumber, :paymentDate, :amount, :created_at, :updated_at
json.url payment_url(payment, format: :json)