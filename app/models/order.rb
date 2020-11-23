class Order < ApplicationRecord
    has_many :order_details, foreign_key => [:orderNumber, :productCode]
end
