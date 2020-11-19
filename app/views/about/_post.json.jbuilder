json.extract! contact, :id, :name, :email, :body
json.url about_url(contact, format: :json)