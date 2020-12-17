class LineItem < ApplicationRecord
    belongs_to :order, :foreign_key => "product_id", optional: true
    belongs_to :product, :foreign_key => "productCode"
    belongs_to :cart
    def total_price
        product.buyPrice * quantity
    end
    def each_price
        product.buyPrice
    end
end
