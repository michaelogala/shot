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

<<<<<<< 3d35a9521331e5e422207c29265641fb3b6fa840
ActiveRecord::Schema.define(version: 20160908102107) do
=======
ActiveRecord::Schema.define(version: 20160908212711) do
>>>>>>> Add devise gem for authentication

  create_table "links", force: :cascade do |t|
    t.string   "given_url",              null: false
    t.string   "slug"
    t.integer  "clicks",     default: 0
    t.string   "title"
    t.string   "snapshot"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

<<<<<<< 3d35a9521331e5e422207c29265641fb3b6fa840
=======
  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

>>>>>>> Add devise gem for authentication
end
