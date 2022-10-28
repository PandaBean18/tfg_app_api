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

ActiveRecord::Schema.define(version: 2022_10_28_094033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rescue_requests", force: :cascade do |t|
    t.string "rescue_request_id", null: false
    t.string "author_id", null: false
    t.string "heading", null: false
    t.string "description", null: false
    t.string "reference_number", null: false
    t.string "longitude", null: false
    t.string "latitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "closed", null: false
    t.index ["author_id"], name: "index_rescue_requests_on_author_id"
    t.index ["rescue_request_id"], name: "index_rescue_requests_on_rescue_request_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "mail", null: false
    t.string "phone", null: false
    t.string "session_token", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
    t.index ["user_id"], name: "index_users_on_user_id", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
