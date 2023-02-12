# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_11_080850) do
  create_table "children", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "cultivars", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fruit_id"
    t.index ["fruit_id"], name: "index_cultivars_on_fruit_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fruits", force: :cascade do |t|
    t.string "name"
    t.integer "food_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_fruits_on_food_id"
  end

  create_table "grandchildren", force: :cascade do |t|
    t.string "name"
    t.integer "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_grandchildren_on_child_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.integer "user_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_id"], name: "index_members_on_user_group_id"
  end

  create_table "parents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reserved_products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sale_by_customers", force: :cascade do |t|
    t.string "memo"
    t.integer "reserved_product_id", null: false
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_sale_by_customers_on_customer_id"
    t.index ["reserved_product_id"], name: "index_sale_by_customers_on_reserved_product_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "memo"
    t.integer "reserved_product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserved_product_id"], name: "index_sales_on_reserved_product_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "children", "parents", on_delete: :cascade
  add_foreign_key "cultivars", "fruits"
  add_foreign_key "fruits", "foods"
  add_foreign_key "grandchildren", "children", on_delete: :cascade
  add_foreign_key "members", "user_groups"
  add_foreign_key "sale_by_customers", "customers"
  add_foreign_key "sale_by_customers", "reserved_products"
  add_foreign_key "sales", "reserved_products"
end
