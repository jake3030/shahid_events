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

ActiveRecord::Schema.define(version: 2020_02_15_181235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "house_events", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cohosts", default: [], array: true
    t.string "email"
    t.string "phone"
    t.string "volunteer"
    t.string "address_street"
    t.string "address_unit_number"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zip"
    t.datetime "event_start_at"
    t.datetime "event_end_at"
    t.text "description"
    t.string "event_link"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "volunteer_events", force: :cascade do |t|
    t.string "action_network_id"
    t.string "title"
    t.string "name"
    t.text "description"
    t.datetime "event_start_at"
    t.datetime "event_end_at"
    t.string "venue"
    t.string "address_street"
    t.string "address_city"
    t.string "address_state", default: "CA", null: false
    t.string "address_zip"
    t.float "latitude"
    t.float "longitude"
    t.string "url"
    t.string "image_url"
    t.jsonb "extras"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
