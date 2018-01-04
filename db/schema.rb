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

ActiveRecord::Schema.define(version: 20180104160007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additions", force: :cascade do |t|
    t.string "name"
    t.string "additionable_type"
    t.bigint "additionable_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["additionable_type", "additionable_id"], name: "index_additions_on_additionable_type_and_additionable_id"
  end

  create_table "cart_fragments", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.bigint "restaurant_id"
    t.bigint "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delivery", default: false
    t.index ["cart_id"], name: "index_cart_fragments_on_cart_id"
    t.index ["restaurant_id"], name: "index_cart_fragments_on_restaurant_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.integer "quantity"
    t.decimal "sub_total"
    t.bigint "cart_fragment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.bigint "variant_id"
    t.index ["cart_fragment_id"], name: "index_cart_items_on_cart_fragment_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["itemable_type", "itemable_id"], name: "index_cart_items_on_itemable_type_and_itemable_id"
    t.index ["variant_id"], name: "index_cart_items_on_variant_id"
  end

  create_table "carts", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
  end

  create_table "drinks", force: :cascade do |t|
    t.string "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id"
    t.string "name"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.index ["restaurant_id"], name: "index_drinks_on_restaurant_id"
  end

  create_table "foods", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
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

  create_table "item_additions", force: :cascade do |t|
    t.bigint "addition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_additionable_id"
    t.string "item_additionable_type"
    t.index ["addition_id"], name: "index_item_additions_on_addition_id"
    t.index ["item_additionable_id", "item_additionable_type"], name: "idx_item_addition_item_additionable_item_additionable_type"
  end

  create_table "menus", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id"
    t.string "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "order_fragments", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "restaurant_id"
    t.boolean "delivery", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.datetime "archived_on"
    t.index ["order_id"], name: "index_order_fragments_on_order_id"
    t.index ["restaurant_id"], name: "index_order_fragments_on_restaurant_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_fragment_id"
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.bigint "variant_id"
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
    t.index ["itemable_type", "itemable_id"], name: "index_order_items_on_itemable_type_and_itemable_id"
    t.index ["order_fragment_id"], name: "index_order_items_on_order_fragment_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["variant_id"], name: "index_order_items_on_variant_id"
  end

  create_table "orders", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.string "full_name"
    t.string "phone_number"
    t.string "location"
    t.string "street"
    t.text "location_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "BZD", null: false
    t.boolean "delivery", default: false
    t.integer "status", default: 0
    t.text "delivery_address"
  end

  create_table "read_marks", id: :serial, force: :cascade do |t|
    t.string "readable_type"
    t.integer "readable_id"
    t.string "reader_type"
    t.integer "reader_id"
    t.datetime "timestamp"
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true
    t.index ["reader_type", "reader_id"], name: "index_read_marks_on_reader_type_and_reader_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "full_name"
    t.string "phone_number"
    t.integer "status", default: 0
    t.date "reserve_date"
    t.time "reserve_time"
    t.integer "persons"
    t.bigint "restaurant_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
  end

  create_table "restaurant_requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile_number"
    t.string "restaurant_phone_number"
    t.integer "number_of_employees"
    t.string "location"
    t.string "street_name"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "restaurant_name"
  end

  create_table "restaurants", id: :bigint, default: -> { "make_random_id()" }, force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "street"
    t.string "phone_number"
    t.text "description"
    t.boolean "setup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_image"
    t.boolean "delivery", default: false
    t.integer "order_medium_type", default: 0
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.time "open"
    t.time "close"
    t.text "recurring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_schedules_on_restaurant_id"
  end

  create_table "specials", force: :cascade do |t|
    t.string "name"
    t.datetime "selling_date"
    t.text "description"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.string "primary_image"
    t.string "address"
    t.index ["restaurant_id"], name: "index_specials_on_restaurant_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "mobile_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobile_number"], name: "index_subscribers_on_mobile_number", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "time_frames", force: :cascade do |t|
    t.time "open"
    t.time "close"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_time_frames_on_schedule_id"
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

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.integer "variantable_id"
    t.string "variantable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BZD", null: false
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_variants_on_restaurant_id"
    t.index ["variantable_id", "variantable_type"], name: "index_variants_on_variantable_id_and_variantable_type"
  end

  add_foreign_key "cart_fragments", "carts"
  add_foreign_key "cart_fragments", "restaurants"
  add_foreign_key "cart_items", "cart_fragments"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "variants"
  add_foreign_key "drinks", "restaurants"
  add_foreign_key "foods", "menus"
  add_foreign_key "foods", "restaurants"
  add_foreign_key "item_additions", "additions"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "order_fragments", "orders"
  add_foreign_key "order_fragments", "restaurants"
  add_foreign_key "order_items", "order_fragments"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "variants"
  add_foreign_key "reservations", "restaurants"
  add_foreign_key "schedules", "restaurants"
  add_foreign_key "specials", "restaurants"
  add_foreign_key "taggings", "tags"
  add_foreign_key "time_frames", "schedules"
  add_foreign_key "users", "restaurants"
  add_foreign_key "variants", "restaurants"
end
