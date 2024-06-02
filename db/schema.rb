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

ActiveRecord::Schema[7.0].define(version: 2024_05_27_064839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "carousel_items", force: :cascade do |t|
    t.string "collectable_type"
    t.bigint "collectable_id"
    t.bigint "carousel_id"
    t.boolean "show_on_homepage", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carousel_id"], name: "index_carousel_items_on_carousel_id"
    t.index ["collectable_type", "collectable_id"], name: "index_carousel_items_on_collectable"
  end

  create_table "carousels", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id", "followee_id"], name: "index_follows_on_follower_id_and_followee_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_question_answers_on_option_id"
    t.index ["question_id"], name: "index_question_answers_on_question_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_question_options_on_option_id"
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quiz_tags", force: :cascade do |t|
    t.bigint "quiz_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_tags_on_quiz_id"
    t.index ["tag_id"], name: "index_quiz_tags_on_tag_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.integer "questions_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "played_count", default: 0
    t.bigint "favorited_count", default: 0
    t.bigint "shared_count", default: 0
    t.integer "total_points", default: 1000
    t.text "image_generation_prompt"
    t.index ["category_id"], name: "index_quizzes_on_category_id"
  end

  create_table "report_cards", force: :cascade do |t|
    t.bigint "quiz_id"
    t.bigint "user_id"
    t.integer "correct_count"
    t.integer "incorrect_count"
    t.integer "no_result_count"
    t.jsonb "given_answers", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score"
    t.index ["quiz_id"], name: "index_report_cards_on_quiz_id"
    t.index ["user_id"], name: "index_report_cards_on_user_id"
  end

  create_table "room_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "joined_at"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_users_on_room_id"
    t.index ["user_id"], name: "index_room_users_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "quiz_id"
    t.string "joining_code"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_rooms_on_quiz_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_quizzes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "quiz_id"
    t.boolean "is_played", default: false
    t.boolean "is_favorited", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_user_quizzes_on_quiz_id"
    t.index ["user_id"], name: "index_user_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname"
    t.string "lastname"
    t.string "email"
    t.string "password"
    t.string "type"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "country_code"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "follows", "users", column: "followee_id"
  add_foreign_key "follows", "users", column: "follower_id"
end
