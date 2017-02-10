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

ActiveRecord::Schema.define(version: 20170210214009) do

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
    t.index ["song_id"], name: "index_recommendations_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "artist",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["spotify_uid"], name: "index_users_on_spotify_uid", unique: true
  end

end
