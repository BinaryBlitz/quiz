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

ActiveRecord::Schema.define(version: 20141217144634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "token"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "api_keys", ["player_id"], name: "index_api_keys_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "points",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "text"
    t.string   "answers",        default: [],              array: true
    t.string   "correct_answer"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "session_questions", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "question_id"
    t.integer  "player_points",   default: 0
    t.integer  "opponent_points", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "session_questions", ["question_id"], name: "index_session_questions_on_question_id", using: :btree
  add_index "session_questions", ["session_id"], name: "index_session_questions_on_session_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "opponent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sessions", ["player_id"], name: "index_sessions_on_player_id", using: :btree

  add_foreign_key "api_keys", "players"
  add_foreign_key "session_questions", "questions"
  add_foreign_key "session_questions", "sessions"
  add_foreign_key "sessions", "players"
end
