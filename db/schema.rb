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

ActiveRecord::Schema.define(version: 20141228234442) do

  create_table "answer_sets", force: true do |t|
    t.integer  "questionnaire_id"
    t.integer  "participant_id"
    t.integer  "schedule_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_sets", ["participant_id"], name: "index_answer_sets_on_participant_id"
  add_index "answer_sets", ["questionnaire_id"], name: "index_answer_sets_on_questionnaire_id"
  add_index "answer_sets", ["schedule_entry_id"], name: "index_answer_sets_on_schedule_entry_id"

  create_table "answer_types", force: true do |t|
    t.string   "label"
    t.string   "description"
    t.integer  "study_id"
    t.boolean  "allow_multiple", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_types", ["study_id"], name: "index_answer_types_on_study_id"

  create_table "answer_validations", force: true do |t|
    t.string   "regular_expression", default: "--- !ruby/regexp /.*/\n...\n"
    t.integer  "answer_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_validations", ["answer_type_id"], name: "index_answer_validations_on_answer_type_id"

  create_table "answers", force: true do |t|
    t.string   "value"
    t.integer  "answer_set_id"
    t.integer  "participant_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["answer_set_id"], name: "index_answers_on_answer_set_id"
  add_index "answers", ["participant_id"], name: "index_answers_on_participant_id"
  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "block_questionnaires", force: true do |t|
    t.integer  "block_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "block_questionnaires", ["block_id"], name: "index_block_questionnaires_on_block_id"
  add_index "block_questionnaires", ["questionnaire_id"], name: "index_block_questionnaires_on_questionnaire_id"

  create_table "blocks", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "choices", force: true do |t|
    t.string   "value"
    t.string   "text"
    t.integer  "order"
    t.integer  "answer_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["answer_type_id"], name: "index_choices_on_answer_type_id"

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["study_id"], name: "index_participants_on_study_id"
  add_index "participants", ["user_id"], name: "index_participants_on_user_id"

  create_table "questionnaires", force: true do |t|
    t.string   "label"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaires", ["study_id"], name: "index_questionnaires_on_study_id"

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "label"
    t.integer  "number"
    t.integer  "block_id"
    t.integer  "answer_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["answer_type_id"], name: "index_questions_on_answer_type_id"
  add_index "questions", ["block_id"], name: "index_questions_on_block_id"

  create_table "schedule_entries", force: true do |t|
    t.datetime "time_to_send"
    t.boolean  "sent"
    t.integer  "participant_id"
    t.integer  "schedule_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_entries", ["participant_id"], name: "index_schedule_entries_on_participant_id"
  add_index "schedule_entries", ["questionnaire_id"], name: "index_schedule_entries_on_questionnaire_id"
  add_index "schedule_entries", ["schedule_id"], name: "index_schedule_entries_on_schedule_id"

  create_table "schedule_template_entries", force: true do |t|
    t.integer  "time_offset_hours"
    t.integer  "schedule_template_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_template_entries", ["questionnaire_id"], name: "index_schedule_template_entries_on_questionnaire_id"
  add_index "schedule_template_entries", ["schedule_template_id"], name: "index_schedule_template_entries_on_schedule_template_id"

  create_table "schedule_templates", force: true do |t|
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_templates", ["study_id"], name: "index_schedule_templates_on_study_id"

  create_table "schedules", force: true do |t|
    t.datetime "start_time"
    t.integer  "participant_id"
    t.integer  "schedule_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["participant_id"], name: "index_schedules_on_participant_id"
  add_index "schedules", ["schedule_template_id"], name: "index_schedules_on_schedule_template_id"

  create_table "studies", force: true do |t|
    t.string   "title"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "address_line_one"
    t.string   "address_line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "name"
    t.boolean  "is_admin"
    t.boolean  "is_valid"
    t.string   "auth_token"
    t.string   "valid_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
