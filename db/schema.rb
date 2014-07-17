# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140717200046) do

  create_table "answers", force: true do |t|
    t.string   "value"
    t.integer  "participant_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["participant_id"], name: "index_answers_on_participant_id"
  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "blocks", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "questionnaire_id"
  end

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["user_id"], name: "index_participants_on_user_id"

  create_table "questionnaires", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "label"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "block_id"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "new"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_line_one"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  default: false
    t.string   "address_line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "name"
    t.string   "valid_token"
    t.boolean  "is_valid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
