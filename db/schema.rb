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

ActiveRecord::Schema.define(version: 2023_02_07_002743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "start_odometer"
    t.integer "end_odometer"
    t.text "start_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.string "end_comment"
    t.index ["driver_id"], name: "index_assignments_on_driver_id"
    t.index ["vehicle_id"], name: "index_assignments_on_vehicle_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birth_date"
    t.string "email"
    t.string "phone_number"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.string "license_number"
    t.string "license_class"
    t.string "license_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_drivers_on_account_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.string "title"
    t.text "description"
    t.integer "priority"
    t.datetime "reported_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_issues_on_account_id"
    t.index ["vehicle_id"], name: "index_issues_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.date "manufacture_year"
    t.string "color"
    t.string "image_url"
    t.string "plate_number"
    t.string "engine_number"
    t.integer "fuel_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.boolean "active", default: true
    t.index ["account_id"], name: "index_vehicles_on_account_id"
  end

  add_foreign_key "assignments", "drivers"
  add_foreign_key "assignments", "vehicles"
  add_foreign_key "issues", "vehicles"
end
