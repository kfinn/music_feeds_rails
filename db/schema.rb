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

ActiveRecord::Schema.define(version: 20170303221836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "device_tokens", force: :cascade do |t|
    t.string   "token",      null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_device_tokens_on_user_id", using: :btree
  end

  create_table "feed_updates", force: :cascade do |t|
    t.string   "feed_id"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["completed_at"], name: "index_feed_updates_on_completed_at", using: :btree
    t.index ["feed_id"], name: "index_feed_updates_on_feed_id", using: :btree
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.string   "spotify_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id", using: :btree
  end

  create_table "recommendations", force: :cascade do |t|
    t.string   "guid",                       null: false
    t.string   "url",                        null: false
    t.string   "creator",                    null: false
    t.string   "description"
    t.integer  "song_id"
    t.datetime "recommended_at",             null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "feed_id",        default: 0, null: false
    t.index ["song_id"], name: "index_recommendations_on_song_id", using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "artist",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "spotify_id"
  end

  create_table "spotify_syncs", force: :cascade do |t|
    t.integer  "playlist_id"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["created_at"], name: "index_spotify_syncs_on_created_at", using: :btree
    t.index ["playlist_id"], name: "index_spotify_syncs_on_playlist_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "spotify_uid",                                  null: false
    t.string   "email",                                        null: false
    t.string   "spotify_credential_token",                     null: false
    t.string   "spotify_credential_refresh_token",             null: false
    t.datetime "spotify_credential_expires_at",                null: false
    t.boolean  "spotify_credential_expires",                   null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["spotify_uid"], name: "index_users_on_spotify_uid", unique: true, using: :btree
  end

  add_foreign_key "spotify_syncs", "playlists"
end
