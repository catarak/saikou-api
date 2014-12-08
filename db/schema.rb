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

ActiveRecord::Schema.define(version: 20141202151639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charts", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "charts", ["country_id"], name: "index_charts_on_country_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: true do |t|
    t.integer  "chart_id"
    t.integer  "week_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "song_id"
  end

  add_index "records", ["chart_id"], name: "index_records_on_chart_id", using: :btree
  add_index "records", ["week_id"], name: "index_records_on_week_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree

  create_table "weeks", force: true do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year_id"
  end

  create_table "years", force: true do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
