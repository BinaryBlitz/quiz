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

ActiveRecord::Schema.define(version: 20141222205542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.boolean  "correct",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "token"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "api_keys", ["player_id"], name: "index_api_keys_on_player_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "imei"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.string   "image_url"
    t.integer  "bounty",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "topic_id"
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id", using: :btree

  create_table "session_questions", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "question_id"
    t.integer  "host_answer_id"
    t.integer  "opponent_answer_id"
    t.integer  "host_time",          default: 0
    t.integer  "opponent_time",      default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "session_questions", ["question_id"], name: "index_session_questions_on_question_id", using: :btree
  add_index "session_questions", ["session_id"], name: "index_session_questions_on_session_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.integer  "host_id"
    t.integer  "opponent_id"
    t.boolean  "online",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "offline",     default: false
    t.integer  "topic_id"
  end

  add_index "sessions", ["host_id"], name: "index_sessions_on_host_id", using: :btree
  add_index "sessions", ["opponent_id"], name: "index_sessions_on_opponent_id", using: :btree
  add_index "sessions", ["topic_id"], name: "index_sessions_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.boolean  "visible",      default: false
    t.date     "expires_at"
    t.integer  "price",        default: 0
    t.integer  "played_count", default: 0
    t.integer  "category_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "topics", ["category_id"], name: "index_topics_on_category_id", using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "api_keys", "players"
  add_foreign_key "questions", "topics"
  add_foreign_key "session_questions", "questions"
  add_foreign_key "session_questions", "sessions"
  add_foreign_key "sessions", "topics"
  add_foreign_key "topics", "categories"
end
