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

ActiveRecord::Schema.define(version: 20150311203519) do

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

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_results", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "category_id"
    t.integer  "points",        default: 0
    t.integer  "weekly_points", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "category_results", ["category_id"], name: "index_category_results_on_category_id", using: :btree
  add_index "category_results", ["player_id"], name: "index_category_results_on_player_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "friend_id"
    t.boolean  "viewed",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "friendships", ["player_id"], name: "index_friendships_on_player_id", using: :btree

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
    t.boolean  "closed"
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
    t.boolean  "challenge",       default: false
  end

  add_index "lobbies", ["game_session_id"], name: "index_lobbies_on_game_session_id", using: :btree
  add_index "lobbies", ["player_id"], name: "index_lobbies_on_player_id", using: :btree
  add_index "lobbies", ["topic_id"], name: "index_lobbies_on_topic_id", using: :btree

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "imei"
    t.integer  "points",          default: 0
    t.integer  "weekly_points",   default: 0
    t.string   "vk_token"
    t.integer  "vk_id"
    t.integer  "sash_id"
    t.integer  "level",           default: 0
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree

  create_table "purchase_types", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "multiplier"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "purchase_types", ["topic_id"], name: "index_purchase_types_on_topic_id", using: :btree

  create_table "purchases", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "purchase_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "purchases", ["player_id"], name: "index_purchases_on_player_id", using: :btree
  add_index "purchases", ["purchase_type_id"], name: "index_purchases_on_purchase_type_id", using: :btree

  create_table "push_tokens", force: :cascade do |t|
    t.string   "token"
    t.boolean  "android",    default: false
    t.integer  "player_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "push_tokens", ["player_id"], name: "index_push_tokens_on_player_id", using: :btree
  add_index "push_tokens", ["token"], name: "index_push_tokens_on_token", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.string   "image_url"
    t.integer  "bounty",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "topic_id"
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id", using: :btree

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_results", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "topic_id"
    t.integer  "points",        default: 0
    t.integer  "weekly_points", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "topic_results", ["player_id"], name: "index_topic_results_on_player_id", using: :btree
  add_index "topic_results", ["topic_id"], name: "index_topic_results_on_topic_id", using: :btree

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
  add_foreign_key "category_results", "categories"
  add_foreign_key "category_results", "players"
  add_foreign_key "friendships", "players"
  add_foreign_key "game_session_questions", "game_sessions"
  add_foreign_key "game_session_questions", "questions"
  add_foreign_key "game_sessions", "topics"
  add_foreign_key "lobbies", "game_sessions"
  add_foreign_key "lobbies", "players"
  add_foreign_key "lobbies", "topics"
  add_foreign_key "purchase_types", "topics"
  add_foreign_key "purchases", "players"
  add_foreign_key "purchases", "purchase_types"
  add_foreign_key "push_tokens", "players"
  add_foreign_key "questions", "topics"
  add_foreign_key "topic_results", "players"
  add_foreign_key "topic_results", "topics"
  add_foreign_key "topics", "categories"
end
