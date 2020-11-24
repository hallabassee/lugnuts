# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_23_202230) do

  create_table "action_text_rich_texts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "edit_history"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.bigint "user_id", null: false
    t.boolean "reply", default: false
    t.integer "comment_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", primary_key: "customerNumber", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "customerName", limit: 50, null: false
    t.string "contactLastName", limit: 50, null: false
    t.string "contactFirstName", limit: 50, null: false
    t.string "phone", limit: 50, null: false
    t.string "addressLine1", limit: 50, null: false
    t.string "addressLine2", limit: 50
    t.string "city", limit: 50, null: false
    t.string "state", limit: 50
    t.string "postalCode", limit: 15
    t.string "country", limit: 50, null: false
    t.integer "salesRepEmployeeNumber"
    t.decimal "creditLimit", precision: 10, scale: 2
    t.integer "user_id"
    t.index ["salesRepEmployeeNumber"], name: "salesRepEmployeeNumber"
  end

  create_table "employees", primary_key: "employeeNumber", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "lastName", limit: 50, null: false
    t.string "firstName", limit: 50, null: false
    t.string "extension", limit: 10, null: false
    t.string "email", limit: 100, null: false
    t.string "officeCode", limit: 10, null: false
    t.integer "reportsTo"
    t.string "jobTitle", limit: 50, null: false
    t.index ["officeCode"], name: "officeCode"
    t.index ["reportsTo"], name: "reportsTo"
  end

  create_table "friendly_id_slugs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "line_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "product_id"
    t.integer "cart_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity", default: 1
  end

  create_table "offices", primary_key: "officeCode", id: :string, limit: 10, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "city", limit: 50, null: false
    t.string "phone", limit: 50, null: false
    t.string "addressLine1", limit: 50, null: false
    t.string "addressLine2", limit: 50
    t.string "state", limit: 50
    t.string "country", limit: 50, null: false
    t.string "postalCode", limit: 15, null: false
    t.string "territory", limit: 10, null: false
  end

  create_table "orderdetails", primary_key: ["orderNumber", "productCode"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "orderNumber", null: false
    t.string "productCode", limit: 15, null: false
    t.integer "quantityOrdered", null: false
    t.decimal "priceEach", precision: 10, scale: 2, null: false
    t.integer "orderLineNumber", limit: 2, null: false
    t.index ["productCode"], name: "productCode"
  end

  create_table "orders", primary_key: "orderNumber", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "orderDate", null: false
    t.date "requiredDate", null: false
    t.date "shippedDate"
    t.string "status", limit: 15, null: false
    t.text "comments"
    t.integer "customerNumber", null: false
    t.boolean "paid", default: false
    t.string "token"
    t.index ["customerNumber"], name: "customerNumber"
  end

  create_table "payments", primary_key: ["customerNumber", "checkNumber"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "customerNumber", null: false
    t.string "checkNumber", limit: 50, null: false
    t.date "paymentDate", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.integer "views", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "category_id"
    t.boolean "featured"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "product_image_maps", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "productCode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["productCode"], name: "index_product_image_maps_on_productCode"
  end

  create_table "productlines", primary_key: "productLine", id: :string, limit: 50, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "textDescription", limit: 4000
    t.text "htmlDescription", size: :medium
    t.binary "image", size: :medium
  end

  create_table "products", primary_key: "productCode", id: :string, limit: 15, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "productName", limit: 70, null: false
    t.string "productLine", limit: 50, null: false
    t.string "productScale", limit: 10, null: false
    t.string "productVendor", limit: 50, null: false
    t.text "productDescription", null: false
    t.integer "quantityInStock", limit: 2, null: false
    t.decimal "buyPrice", precision: 10, scale: 2, null: false
    t.decimal "MSRP", precision: 10, scale: 2, null: false
    t.boolean "featured"
    t.index ["productLine"], name: "productLine"
  end

  create_table "subscribers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.boolean "member", default: false
    t.integer "number_of_comments", default: 0
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "customers", "employees", column: "salesRepEmployeeNumber", primary_key: "employeeNumber", name: "customers_ibfk_1"
  add_foreign_key "employees", "employees", column: "reportsTo", primary_key: "employeeNumber", name: "employees_ibfk_1"
  add_foreign_key "employees", "offices", column: "officeCode", primary_key: "officeCode", name: "employees_ibfk_2"
  add_foreign_key "orderdetails", "orders", column: "orderNumber", primary_key: "orderNumber", name: "orderdetails_ibfk_1"
  add_foreign_key "orderdetails", "products", column: "productCode", primary_key: "productCode", name: "orderdetails_ibfk_2"
  add_foreign_key "orders", "customers", column: "customerNumber", primary_key: "customerNumber", name: "orders_ibfk_1"
  add_foreign_key "payments", "customers", column: "customerNumber", primary_key: "customerNumber", name: "payments_ibfk_1"
  add_foreign_key "posts", "users"
  add_foreign_key "product_image_maps", "products", column: "productCode", primary_key: "productCode"
  add_foreign_key "products", "productlines", column: "productLine", primary_key: "productLine", name: "products_ibfk_1"
end
