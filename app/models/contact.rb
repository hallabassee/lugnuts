class Contact < ApplicationRecord

    validates :name, presence: true
    validates :email, email: true
    validates :body, presence: true

end