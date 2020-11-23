class Orderdetail < ApplicationRecord
    self.primary_keys = :orderNumber, :productCode
    belongs_to :order, :foreign_key => "orderNumber"
end
