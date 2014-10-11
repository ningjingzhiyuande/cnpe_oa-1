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

ActiveRecord::Schema.define(version: 20141003143318) do

  create_table "categories", force: true do |t|
    t.integer  "kind",       default: 0
    t.integer  "user_id"
    t.string   "item_num"
    t.string   "name"
    t.string   "info"
    t.string   "position"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["item_num"], name: "index_categories_on_item_num", using: :btree
  add_index "categories", ["kind"], name: "index_categories_on_kind", using: :btree

  create_table "date_settings", force: true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "work_status", default: 0
    t.string   "data"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "date_settings", ["work_status"], name: "index_date_settings_on_work_status", using: :btree
  add_index "date_settings", ["year"], name: "index_date_settings_on_year", using: :btree

  create_table "delayed_jobs", force: true do |t|
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
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "leave_details", force: true do |t|
    t.integer  "user_id"
    t.integer  "leave_id"
    t.string   "data"
    t.decimal  "days",       precision: 5, scale: 1
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "kind"
    t.integer  "status",                             default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "leave_details", ["kind"], name: "index_leave_details_on_kind", using: :btree
  add_index "leave_details", ["leave_id"], name: "index_leave_details_on_leave_id", using: :btree
  add_index "leave_details", ["user_id"], name: "index_leave_details_on_user_id", using: :btree

  create_table "leaves", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "status",                               default: 0
    t.decimal  "total_days",   precision: 5, scale: 1
    t.text     "info"
    t.string   "image"
    t.integer  "reporter1_id"
    t.integer  "reporter2_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "leaves", ["user_id"], name: "index_leaves_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "department_id"
    t.integer  "rank_id",                default: 1
    t.date     "work_at"
    t.integer  "gender"
    t.boolean  "is_approve",             default: false
    t.boolean  "is_admin",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_approve"], name: "index_users_on_is_approve", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
