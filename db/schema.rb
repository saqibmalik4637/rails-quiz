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

ActiveRecord::Schema[7.0].define(version: 2024_05_12_063029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
