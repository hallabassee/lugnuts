class CreateProductImageMap < ActiveRecord::Migration[6.0]
  def up
    create_table :product_image_maps do |t|
      t.string :productCode, index: true, :limit => 15
      t.foreign_key(:products, column: :productCode, primary_key: "productCode",  type: :string)
      t.timestamps
    end
    # populate the table from the products table
    execute "INSERT INTO product_image_maps (productCode, created_at, updated_at) SELECT productCode, NOW(), NOW() FROM products"
  end

  def down

  end
end
