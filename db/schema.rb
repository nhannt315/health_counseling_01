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

ActiveRecord::Schema.define(version: 2018_08_17_015648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.text "content_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "category_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.integer "doctor_id"
    t.integer "category_id"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.boolean "accept"
    t.string "reason"
    t.string "state"
    t.string "location"
    t.string "schedule_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.text "title"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.boolean "closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id", "sender_id"], name: "index_conversations_on_receiver_id_and_sender_id", unique: true
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.text "content_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "category_id"
  end

  create_table "doctor_majors", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_doctor_majors_on_major_id"
    t.index ["user_id"], name: "index_doctor_majors_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "target_id"
    t.string "target_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicine_classes", force: :cascade do |t|
    t.string "name"
  end

  create_table "medicine_types", force: :cascade do |t|
    t.string "name"
    t.bigint "medicine_class_id"
    t.string "slug"
    t.index ["medicine_class_id"], name: "index_medicine_types_on_medicine_class_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.bigint "medicine_type_id"
    t.string "company"
    t.text "overview"
    t.text "instruction"
    t.text "info"
    t.text "warning"
    t.text "contraindication"
    t.text "side_effect"
    t.text "note"
    t.text "overdose"
    t.text "preservation"
    t.string "slug"
    t.index ["medicine_type_id"], name: "index_medicines_on_medicine_type_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "question_id"
    t.bigint "major_id"
    t.boolean "checked"
    t.integer "notification_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
    t.integer "receiver_id"
    t.index ["major_id"], name: "index_notifications_on_major_id"
    t.index ["question_id"], name: "index_notifications_on_question_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
  end

  create_table "question_categories", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_question_categories_on_major_id"
    t.index ["question_id"], name: "index_question_categories_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_questions_on_slug"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.string "remember_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.boolean "admin"
    t.string "avatar"
    t.string "type"
    t.string "prof_place"
    t.string "prof_spec"
    t.string "identity_card"
    t.string "license"
    t.string "info_confirmed"
    t.text "bio"
    t.string "prof_position"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.boolean "request_doctor"
    t.boolean "doctor_activated"
    t.boolean "recommend"
    t.integer "block_status"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "slug"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "doctor_majors", "users"
  add_foreign_key "medicine_types", "medicine_classes"
  add_foreign_key "medicines", "medicine_types"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "majors"
  add_foreign_key "notifications", "questions"
  add_foreign_key "notifications", "users", column: "sender_id"
  add_foreign_key "question_categories", "majors"
  add_foreign_key "question_categories", "questions"
  add_foreign_key "questions", "users"
end
