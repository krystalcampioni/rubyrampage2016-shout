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

ActiveRecord::Schema.define(version: 20161023200627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reactions", force: :cascade do |t|
    t.string   "emoji"
    t.integer  "shout_id"
    t.string   "user_identifier"
    t.integer  "counter",         default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["shout_id"], name: "index_reactions_on_shout_id", using: :btree
  end

  create_table "shout_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shout_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shout_id"], name: "index_shout_users_on_shout_id", using: :btree
    t.index ["user_id"], name: "index_shout_users_on_user_id", using: :btree
  end

  create_table "shouts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "shouter_id"
    t.text     "message"
    t.index ["shouter_id"], name: "index_shouts_on_shouter_id", using: :btree
    t.index ["user_id"], name: "index_shouts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "profile_image_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_foreign_key "reactions", "shouts"
  add_foreign_key "shout_users", "shouts"
  add_foreign_key "shout_users", "users"
  add_foreign_key "shouts", "users"
end
