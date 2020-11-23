class Order < ApplicationRecord
    self.primary_key = 'orderNumber'
    has_many :orderdetails, :foreign_key => [:orderNumber, :productCode], dependent: :destroy
end
