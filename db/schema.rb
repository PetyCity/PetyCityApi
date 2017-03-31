# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170329174343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.float    "total_price", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_category", null: false
    t.text     "details",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "category_products", force: :cascade do |t|
    t.integer  "product_id",  null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_category_products_on_category_id", using: :btree
    t.index ["product_id", "category_id"], name: "index_category_products_on_product_id_and_category_id", unique: true, using: :btree
    t.index ["product_id"], name: "index_category_products_on_product_id", using: :btree
  end

  create_table "comment_products", force: :cascade do |t|
    t.text     "body_comment_product"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["product_id"], name: "index_comment_products_on_product_id", using: :btree
    t.index ["user_id"], name: "index_comment_products_on_user_id", using: :btree
  end

  create_table "comment_publications", force: :cascade do |t|
    t.text     "body_comment_Publication", default: "", null: false
    t.integer  "publication_id",                        null: false
    t.integer  "user_id",                               null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["publication_id"], name: "index_comment_publications_on_publication_id", using: :btree
    t.index ["user_id"], name: "index_comment_publications_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.bigint   "nit"
    t.string   "name_comp"
    t.string   "address",    limit: 30
    t.string   "city",       limit: 20
    t.bigint   "phone"
    t.boolean  "permission",            default: false
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "name_image", limit: 20, null: false
    t.integer  "product_id",            null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["product_id"], name: "index_images_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name_product",                 null: false
    t.text     "description",                  null: false
    t.boolean  "status",       default: false
    t.integer  "value",                        null: false
    t.integer  "amount",                       null: false
    t.integer  "company_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["company_id"], name: "index_products_on_company_id", using: :btree
    t.index ["name_product", "company_id"], name: "index_products_on_name_product_and_company_id", unique: true, using: :btree
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title",                         null: false
    t.text     "body_publication", default: "", null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_publications_on_user_id", using: :btree
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.integer  "cart_id",    null: false
    t.bigint   "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "product_id"], name: "index_sales_on_cart_id_and_product_id", unique: true, using: :btree
    t.index ["cart_id"], name: "index_sales_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_sales_on_product_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.integer  "cart_id",    null: false
    t.bigint   "amount",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "product_id"], name: "index_transactions_on_cart_id_and_product_id", unique: true, using: :btree
    t.index ["cart_id"], name: "index_transactions_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_transactions_on_product_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "cedula"
    t.string   "name_user"
    t.boolean  "block",                             default: false
    t.boolean  "sendEmail",                         default: false
    t.integer  "rol"
    t.integer  "image"
    t.string   "authentication_token",   limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "carts", "users"
  add_foreign_key "category_products", "categories"
  add_foreign_key "category_products", "products"
  add_foreign_key "comment_products", "products"
  add_foreign_key "comment_products", "users"
  add_foreign_key "comment_publications", "publications"
  add_foreign_key "comment_publications", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "images", "products"
  add_foreign_key "products", "companies"
  add_foreign_key "publications", "users"
  add_foreign_key "sales", "carts"
  add_foreign_key "sales", "products"
  add_foreign_key "transactions", "carts"
  add_foreign_key "transactions", "products"
end
