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

ActiveRecord::Schema.define(version: 2024_12_02_090716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "birth_date", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.string "address1", null: false
    t.string "address2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "country"
    t.string "license_number", null: false
    t.string "license_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id", null: false
    t.index ["account_id"], name: "index_drivers_on_account_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.text "description", null: false
    t.integer "priority", null: false
    t.datetime "due_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id", null: false
    t.boolean "completed", default: false
    t.index ["account_id"], name: "index_issues_on_account_id"
    t.index ["vehicle_id"], name: "index_issues_on_vehicle_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.bigint "vehicle_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "departure_location"
    t.string "arrival_location"
    t.string "distance"
    t.string "duration"
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model", null: false
    t.datetime "manufacture_year", null: false
    t.string "image_url"
    t.string "plate_number", null: false
    t.string "engine_number", null: false
    t.integer "fuel_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id", null: false
    t.boolean "active", default: true
    t.index ["account_id"], name: "index_vehicles_on_account_id"
  end

  add_foreign_key "issues", "vehicles"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "vehicles"
end
