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

ActiveRecord::Schema.define(version: 2021_01_12_174541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "authentications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "default_menu_items", id: false, force: :cascade do |t|
    t.uuid "default_menu_id", null: false
    t.uuid "item_id", null: false
  end

  create_table "default_menus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", id: false, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "place_id", null: false
  end

  create_table "items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "description"
    t.string "size"
    t.string "image"
    t.float "price"
    t.index ["name"], name: "index_items_on_name"
  end

  create_table "menu_items", id: false, force: :cascade do |t|
    t.uuid "menu_id", null: false
    t.uuid "item_id", null: false
  end

  create_table "menus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "place_id", null: false
    t.index ["place_id"], name: "index_menus_on_place_id"
  end

  create_table "places", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "address"
    t.string "hood"
    t.string "city"
    t.string "province"
    t.string "postcode"
    t.float "latitude"
    t.float "longitude"
    t.string "uid"
    t.string "phone"
    t.string "website"
  end

  create_table "positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.inet "ip_address"
    t.string "city"
    t.string "province"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.integer "count"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "email"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "menus", "places"
  add_foreign_key "roles", "users"
end
