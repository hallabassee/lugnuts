class Customer < ApplicationRecord
    self.primary_key = 'customerNumber'
    has_many :orders, :foreign_key => :customerNumber
    belongs_to :user, optional: true
end
