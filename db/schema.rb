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

ActiveRecord::Schema.define(version: 2021_02_17_123043) do

  create_table "clips", charset: "utf8mb4", force: :cascade do |t|
    t.string "clipName"
    t.string "uploadUser"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "video"
    t.bigint "decision_id"
    t.bigint "sanction_id"
    t.index ["decision_id"], name: "index_clips_on_decision_id"
    t.index ["sanction_id"], name: "index_clips_on_sanction_id"
  end

  create_table "decisions", charset: "utf8mb4", force: :cascade do |t|
    t.string "description"
    t.string "initials"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", charset: "utf8mb4", force: :cascade do |t|
    t.string "description"
    t.integer "likes_counter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sanctions", charset: "utf8mb4", force: :cascade do |t|
    t.string "description"
    t.string "initials"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topics", charset: "utf8mb4", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "profile_id", null: false
    t.index ["profile_id"], name: "index_users_on_profile_id"
  end

  add_foreign_key "clips", "decisions"
  add_foreign_key "clips", "sanctions"
  add_foreign_key "users", "profiles"
end
