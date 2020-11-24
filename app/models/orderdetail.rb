class Orderdetail < ApplicationRecord
    self.primary_keys = :orderNumber, :productCode
    belongs_to :order, :foreign_key => "orderNumber"
    belongs_to :product, :foreign_key => "productCode"
end
