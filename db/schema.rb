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

ActiveRecord::Schema.define(version: 2018_07_23_081016) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "users_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["users_id"], name: "index_answers_on_users_id"
  end

  create_table "doctor_majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_doctor_majors_on_major_id"
    t.index ["users_id"], name: "index_doctor_majors_on_users_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "target_id"
    t.string "target_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "question_id"
    t.bigint "major_id"
    t.boolean "checked"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_notifications_on_major_id"
    t.index ["question_id"], name: "index_notifications_on_question_id"
    t.index ["users_id"], name: "index_notifications_on_users_id"
  end

  create_table "question_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_question_categories_on_major_id"
    t.index ["question_id"], name: "index_question_categories_on_question_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_questions_on_users_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated"
    t.string "password_digest"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.boolean "admin"
    t.string "avatar"
    t.string "type"
    t.string "prof_place"
    t.string "prof_spec"
    t.string "identity_card"
    t.string "license"
    t.string "info_confirmed"
    t.string "bio"
    t.string "prof_position"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users", column: "users_id"
  add_foreign_key "doctor_majors", "users", column: "users_id"
  add_foreign_key "notifications", "majors"
  add_foreign_key "notifications", "questions"
  add_foreign_key "notifications", "users", column: "users_id"
  add_foreign_key "question_categories", "majors"
  add_foreign_key "question_categories", "questions"
  add_foreign_key "questions", "users", column: "users_id"
end
