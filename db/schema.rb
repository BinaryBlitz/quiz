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

ActiveRecord::Schema.define(version: 20150924233119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer  "badge_id"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string   "background"
    t.string   "banner"
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

  create_table "device_tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "platform"
  end

  add_index "device_tokens", ["player_id"], name: "index_device_tokens_on_player_id", using: :btree
  add_index "device_tokens", ["token"], name: "index_device_tokens_on_token", using: :btree

  create_table "facts", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_requests", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friend_requests", ["friend_id"], name: "index_friend_requests_on_friend_id", using: :btree
  add_index "friend_requests", ["player_id", "friend_id"], name: "index_friend_requests_on_player_id_and_friend_id", unique: true, using: :btree
  add_index "friend_requests", ["player_id"], name: "index_friend_requests_on_player_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friendships", ["player_id"], name: "index_friendships_on_player_id", using: :btree

  create_table "game_questions", force: :cascade do |t|
    t.integer  "game_session_id"
    t.integer  "question_id"
    t.integer  "host_answer_id"
    t.integer  "opponent_answer_id"
    t.integer  "host_time"
    t.integer  "opponent_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "game_questions", ["game_session_id"], name: "index_game_questions_on_game_session_id", using: :btree
  add_index "game_questions", ["question_id"], name: "index_game_questions_on_question_id", using: :btree

  create_table "game_sessions", force: :cascade do |t|
    t.integer  "host_id"
    t.integer  "opponent_id"
    t.boolean  "offline",     default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "topic_id"
    t.boolean  "closed"
    t.integer  "finisher_id"
  end

  add_index "game_sessions", ["finisher_id"], name: "index_game_sessions_on_finisher_id", using: :btree
  add_index "game_sessions", ["host_id"], name: "index_game_sessions_on_host_id", using: :btree
  add_index "game_sessions", ["opponent_id"], name: "index_game_sessions_on_opponent_id", using: :btree
  add_index "game_sessions", ["topic_id"], name: "index_game_sessions_on_topic_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  add_index "invites", ["player_id"], name: "index_invites_on_player_id", using: :btree
  add_index "invites", ["room_id", "player_id"], name: "index_invites_on_room_id_and_player_id", unique: true, using: :btree
  add_index "invites", ["room_id"], name: "index_invites_on_room_id", using: :btree

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

  create_table "participations", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "room_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "topic_id"
    t.boolean  "ready",      default: false
    t.boolean  "finished",   default: false
  end

  add_index "participations", ["player_id", "room_id"], name: "index_participations_on_player_id_and_room_id", unique: true, using: :btree
  add_index "participations", ["player_id"], name: "index_participations_on_player_id", using: :btree
  add_index "participations", ["room_id"], name: "index_participations_on_room_id", using: :btree
  add_index "participations", ["topic_id"], name: "index_participations_on_topic_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "vk_token"
    t.integer  "vk_id"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.string   "avatar"
    t.string   "username"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "token"
    t.datetime "visited_at"
    t.string   "vk_avatar"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["username"], name: "index_players_on_username", unique: true, using: :btree

  create_table "proposals", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "topic_id"
    t.text     "content"
    t.text     "answers",                 array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proposals", ["player_id"], name: "index_proposals_on_player_id", using: :btree
  add_index "proposals", ["topic_id"], name: "index_proposals_on_topic_id", using: :btree

  create_table "purchase_types", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "topic"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "purchase_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "purchases", ["player_id"], name: "index_purchases_on_player_id", using: :btree
  add_index "purchases", ["purchase_type_id"], name: "index_purchases_on_purchase_type_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "topic_id"
    t.string   "image"
    t.integer  "reports_count", default: 0
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "player_id"
    t.text     "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "reports", ["player_id"], name: "index_reports_on_player_id", using: :btree
  add_index "reports", ["question_id"], name: "index_reports_on_question_id", using: :btree

  create_table "room_answers", force: :cascade do |t|
    t.integer  "room_question_id"
    t.integer  "player_id"
    t.integer  "time"
    t.integer  "answer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "room_answers", ["answer_id"], name: "index_room_answers_on_answer_id", using: :btree
  add_index "room_answers", ["player_id"], name: "index_room_answers_on_player_id", using: :btree
  add_index "room_answers", ["room_question_id"], name: "index_room_answers_on_room_question_id", using: :btree

  create_table "room_questions", force: :cascade do |t|
    t.integer  "room_session_id"
    t.integer  "question_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "room_questions", ["question_id"], name: "index_room_questions_on_question_id", using: :btree
  add_index "room_questions", ["room_session_id"], name: "index_room_questions_on_room_session_id", using: :btree

  create_table "room_sessions", force: :cascade do |t|
    t.integer  "room_id"
    t.boolean  "closed",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "room_sessions", ["room_id"], name: "index_room_sessions_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "friends_only", default: false
    t.boolean  "started",      default: false
    t.integer  "size"
    t.integer  "topic_id"
  end

  add_index "rooms", ["player_id"], name: "index_rooms_on_player_id", using: :btree
  add_index "rooms", ["topic_id"], name: "index_rooms_on_topic_id", using: :btree

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "days_in_a_row", default: 0
    t.date     "played_at"
    t.integer  "player_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "early_wins",    default: 0
  end

  add_index "stats", ["player_id"], name: "index_stats_on_player_id", using: :btree

  create_table "topic_results", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "topic_id"
    t.integer  "points",        default: 0
    t.integer  "weekly_points", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "category_id"
    t.integer  "count",         default: 0
    t.integer  "wins",          default: 0
    t.integer  "draws",         default: 0
    t.integer  "losses",        default: 0
  end

  add_index "topic_results", ["category_id"], name: "index_topic_results_on_category_id", using: :btree
  add_index "topic_results", ["player_id"], name: "index_topic_results_on_player_id", using: :btree
  add_index "topic_results", ["topic_id"], name: "index_topic_results_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.boolean  "visible",     default: true
    t.date     "expires_at"
    t.integer  "category_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "featured",    default: false
    t.boolean  "paid",        default: false
  end

  add_index "topics", ["category_id"], name: "index_topics_on_category_id", using: :btree

  add_foreign_key "category_results", "categories"
  add_foreign_key "category_results", "players"
  add_foreign_key "device_tokens", "players"
  add_foreign_key "friend_requests", "players"
  add_foreign_key "friendships", "players"
  add_foreign_key "game_questions", "game_sessions"
  add_foreign_key "game_questions", "questions"
  add_foreign_key "game_sessions", "topics"
  add_foreign_key "invites", "players"
  add_foreign_key "lobbies", "game_sessions"
  add_foreign_key "lobbies", "players"
  add_foreign_key "lobbies", "topics"
  add_foreign_key "participations", "players"
  add_foreign_key "participations", "topics"
  add_foreign_key "purchases", "players"
  add_foreign_key "purchases", "purchase_types"
  add_foreign_key "questions", "topics"
  add_foreign_key "reports", "players"
  add_foreign_key "room_answers", "answers"
  add_foreign_key "room_answers", "players"
  add_foreign_key "room_answers", "room_questions"
  add_foreign_key "room_questions", "questions"
  add_foreign_key "room_questions", "room_sessions"
  add_foreign_key "room_sessions", "rooms"
  add_foreign_key "rooms", "players"
  add_foreign_key "stats", "players"
  add_foreign_key "topic_results", "categories"
  add_foreign_key "topic_results", "players"
  add_foreign_key "topic_results", "topics"
  add_foreign_key "topics", "categories"
end
