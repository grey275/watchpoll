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

ActiveRecord::Schema.define(version: 2019_06_26_024749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidate_videos", force: :cascade do |t|
    t.bigint "video_poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "video_id"
    t.index ["video_poll_id"], name: "index_candidate_videos_on_video_poll_id"
  end

  create_table "chat_events", force: :cascade do |t|
    t.bigint "room_id"
    t.string "type"
    t.string "data"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_chat_events_on_room_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "playlist_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preference_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_session_id"
    t.bigint "video_poll_id"
    t.index ["user_session_id"], name: "index_preference_orders_on_user_session_id"
    t.index ["video_poll_id"], name: "index_preference_orders_on_video_poll_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "position"
    t.bigint "candidate_video_id"
    t.bigint "preference_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_video_id"], name: "index_preferences_on_candidate_video_id"
    t.index ["preference_order_id"], name: "index_preferences_on_preference_order_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "runtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "playlist_id"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_sessions_on_room_id"
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "video_polls", force: :cascade do |t|
    t.bigint "room_id"
    t.time "poll_open_time"
    t.string "played_video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_video_polls_on_room_id"
  end

  create_table "videos", force: :cascade do |t|
    t.bigint "playlist_id"
    t.string "video_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_videos_on_playlist_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "candidate_video_id"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_video_id"], name: "index_votes_on_candidate_video_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "candidate_videos", "video_polls"
  add_foreign_key "candidate_videos", "videos"
  add_foreign_key "chat_events", "rooms"
  add_foreign_key "preference_orders", "user_sessions"
  add_foreign_key "preference_orders", "video_polls"
  add_foreign_key "preferences", "candidate_videos"
  add_foreign_key "preferences", "preference_orders"
  add_foreign_key "rooms", "playlists"
  add_foreign_key "user_sessions", "rooms"
  add_foreign_key "user_sessions", "users"
  add_foreign_key "video_polls", "rooms"
  add_foreign_key "videos", "playlists"
  add_foreign_key "votes", "candidate_videos"
  add_foreign_key "votes", "users"
end
