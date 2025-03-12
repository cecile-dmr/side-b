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

ActiveRecord::Schema[7.1].define(version: 2025_03_12_103327) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_conversations_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vinyle_a"
    t.integer "vinyle_b"
    t.index ["vinyle_a", "vinyle_b"], name: "index_vinyles_matches", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_messages_on_match_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vinyle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_likes_on_user_id"
    t.index ["vinyle_id"], name: "index_user_likes_on_vinyle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.text "bio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vinyles", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.text "description"
    t.boolean "available"
    t.string "quality"
    t.string "year"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vinyles_on_user_id"
  end

  add_foreign_key "conversations", "matches"
  add_foreign_key "matches", "vinyles", column: "vinyle_a"
  add_foreign_key "matches", "vinyles", column: "vinyle_b"
  add_foreign_key "messages", "matches"
  add_foreign_key "messages", "users"
  add_foreign_key "user_likes", "users"
  add_foreign_key "user_likes", "vinyles"
  add_foreign_key "vinyles", "users"
end
