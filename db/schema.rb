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

ActiveRecord::Schema.define(version: 20150212092812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.boolean  "correct",     default: false, null: false
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

  create_table "game_session_questions", force: :cascade do |t|
    t.integer  "game_session_id"
    t.integer  "question_id"
    t.integer  "host_answer_id"
    t.integer  "opponent_answer_id"
    t.integer  "host_time"
    t.integer  "opponent_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "game_session_questions", ["game_session_id"], name: "index_game_session_questions_on_game_session_id", using: :btree
  add_index "game_session_questions", ["question_id"], name: "index_game_session_questions_on_question_id", using: :btree

  create_table "game_sessions", force: :cascade do |t|
    t.integer  "host_id"
    t.integer  "opponent_id"
    t.boolean  "offline",     default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "topic_id"
    t.boolean  "finished",    default: false
  end

  add_index "game_sessions", ["host_id"], name: "index_game_sessions_on_host_id", using: :btree
  add_index "game_sessions", ["opponent_id"], name: "index_game_sessions_on_opponent_id", using: :btree
  add_index "game_sessions", ["topic_id"], name: "index_game_sessions_on_topic_id", using: :btree

  create_table "lobbies", force: :cascade do |t|
    t.integer  "query_count",     default: 0
    t.boolean  "closed",          default: false
    t.integer  "topic_id"
    t.integer  "player_id"
    t.integer  "game_session_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "lobbies", ["game_session_id"], name: "index_lobbies_on_game_session_id", using: :btree
  add_index "lobbies", ["player_id"], name: "index_lobbies_on_player_id", using: :btree
  add_index "lobbies", ["topic_id"], name: "index_lobbies_on_topic_id", using: :btree

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

  create_table "results", force: :cascade do |t|
    t.integer  "points"
    t.integer  "player_id",  null: false
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["player_id"], name: "index_results_on_player_id", using: :btree
  add_index "results", ["topic_id"], name: "index_results_on_topic_id", using: :btree

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
  add_foreign_key "game_session_questions", "game_sessions"
  add_foreign_key "game_session_questions", "questions"
  add_foreign_key "game_sessions", "topics"
  add_foreign_key "lobbies", "game_sessions"
  add_foreign_key "lobbies", "players"
  add_foreign_key "lobbies", "topics"
  add_foreign_key "questions", "topics"
  add_foreign_key "results", "players"
  add_foreign_key "results", "topics"
  add_foreign_key "topics", "categories"
end
