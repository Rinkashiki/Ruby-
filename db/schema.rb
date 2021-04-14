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

ActiveRecord::Schema.define(version: 2021_04_07_114936) do

  create_table "activities", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "responsible"
    t.datetime "initial_date"
    t.datetime "final_date"
    t.datetime "result_date"
    t.decimal "grade", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "activities_questions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_activities_questions_on_activity_id"
    t.index ["question_id"], name: "index_activities_questions_on_question_id"
  end

  create_table "activities_users", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.integer "last_question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_activities_users_on_activity_id"
    t.index ["user_id"], name: "index_activities_users_on_user_id"
  end

  create_table "activity_user_answers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "activities_users_id", null: false
    t.bigint "answer_id"
    t.bigint "decision_id"
    t.bigint "sanction_id"
    t.text "open_question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activities_users_id"], name: "index_activity_user_answers_on_activities_users_id"
    t.index ["answer_id"], name: "index_activity_user_answers_on_answer_id"
    t.index ["decision_id"], name: "index_activity_user_answers_on_decision_id"
    t.index ["sanction_id"], name: "index_activity_user_answers_on_sanction_id"
  end

  create_table "answers", charset: "utf8mb4", force: :cascade do |t|
    t.string "description"
    t.string "option"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "clips", charset: "utf8mb4", force: :cascade do |t|
    t.string "clipName"
    t.string "uploadUser"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "video"
    t.bigint "decision_id"
    t.bigint "sanction_id"
    t.bigint "question_id"
    t.index ["decision_id"], name: "index_clips_on_decision_id"
    t.index ["question_id"], name: "index_clips_on_question_id"
    t.index ["sanction_id"], name: "index_clips_on_sanction_id"
  end

  create_table "clips_topics", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "clip_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clip_id"], name: "index_clips_topics_on_clip_id"
    t.index ["topic_id"], name: "index_clips_topics_on_topic_id"
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

  create_table "questions", charset: "utf8mb4", force: :cascade do |t|
    t.string "question"
    t.string "question_type"
    t.decimal "response_time", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "clip_id"
    t.index ["clip_id"], name: "index_questions_on_clip_id"
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

  add_foreign_key "activities_questions", "activities"
  add_foreign_key "activities_questions", "questions"
  add_foreign_key "activities_users", "activities"
  add_foreign_key "activities_users", "users"
  add_foreign_key "activity_user_answers", "activities_users", column: "activities_users_id"
  add_foreign_key "activity_user_answers", "answers"
  add_foreign_key "activity_user_answers", "decisions"
  add_foreign_key "activity_user_answers", "sanctions"
  add_foreign_key "answers", "questions"
  add_foreign_key "clips", "decisions"
  add_foreign_key "clips", "questions"
  add_foreign_key "clips", "sanctions"
  add_foreign_key "clips_topics", "clips"
  add_foreign_key "clips_topics", "topics"
  add_foreign_key "questions", "clips"
  add_foreign_key "users", "profiles"
end
