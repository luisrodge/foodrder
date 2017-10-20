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

ActiveRecord::Schema.define(version: 20171020195230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_fragments", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_fragments_on_cart_id"
    t.index ["restaurant_id"], name: "index_cart_fragments_on_restaurant_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "food_id"
    t.integer "quantity"
    t.decimal "sub_total"
    t.bigint "cart_fragment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_fragment_id"], name: "index_cart_items_on_cart_fragment_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["food_id"], name: "index_cart_items_on_food_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "restaurant_id"
    t.bigint "menu_id"
    t.string "primary_image"
    t.time "estimated_cook_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.index ["menu_id"], name: "index_foods_on_menu_id"
    t.index ["restaurant_id"], name: "index_foods_on_restaurant_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id"
    t.string "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "street"
    t.string "phone_number"
    t.text "description"
    t.boolean "setup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_image"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
  end

  add_foreign_key "cart_fragments", "carts"
  add_foreign_key "cart_fragments", "restaurants"
  add_foreign_key "cart_items", "cart_fragments"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "foods"
  add_foreign_key "foods", "menus"
  add_foreign_key "foods", "restaurants"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "users", "restaurants"
end
