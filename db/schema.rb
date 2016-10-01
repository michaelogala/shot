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

ActiveRecord::Schema.define(version: 20160930180413) do

  create_table "links", force: :cascade do |t|
    t.string   "given_url",                 null: false
    t.string   "slug"
    t.integer  "clicks",     default: 0
    t.string   "title"
    t.boolean  "active",     default: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "links", ["given_url"], name: "index_links_on_given_url"
  add_index "links", ["slug"], name: "index_links_on_slug"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "link_count"
  end

  add_index "users", ["email"], name: "index_users_on_email"

  create_table "visits", force: :cascade do |t|
    t.integer  "link_id"
    t.string   "ip_address"
    t.string   "browser_name"
    t.string   "browser_version"
    t.string   "device"
    t.string   "os"
    t.string   "referer"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
