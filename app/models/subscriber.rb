class Subscriber < ApplicationRecord

    validates :name, presence: true
    validates :email, email: true, uniqueness: { message: "has already been registered" }

  end