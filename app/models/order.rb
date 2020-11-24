class Order < ApplicationRecord
    self.primary_key = 'orderNumber'
    belongs_to :customer, :foreign_key => :customerNumber
    has_many :orderdetails, :foreign_key => [:orderNumber, :productCode], dependent: :destroy
end
