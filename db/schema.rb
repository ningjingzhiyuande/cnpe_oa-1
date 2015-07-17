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

ActiveRecord::Schema.define(version: 20150701091319) do

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

  create_table "cms_articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.boolean  "is_recommend", default: false
    t.integer  "kind",         default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cms_dangquns", force: true do |t|
    t.string   "title"
    t.string   "document"
    t.boolean  "is_recommend", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cms_departments", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "is_recommend", default: false
    t.string   "image"
    t.integer  "kind"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cms_homes", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "image"
    t.integer  "kind"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "entretains", force: true do |t|
    t.integer  "user_id"
    t.integer  "reporter_id"
    t.string   "title"
    t.string   "num"
    t.text     "content"
    t.string   "attache"
    t.string   "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.integer  "last_reporter_id"
    t.string   "fee"
  end

  create_table "examines", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "review_id"
    t.integer  "user_id"
    t.integer  "position",       default: 0
    t.integer  "status",         default: 0
    t.boolean  "current_review", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "goods", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "descript"
    t.boolean  "is_consume", default: false
    t.boolean  "is_return",  default: false
    t.integer  "loan_num",   default: 0
    t.integer  "stock_num",  default: 0
    t.integer  "apply_num",  default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "goods", ["is_consume"], name: "index_goods_on_is_consume", using: :btree
  add_index "goods", ["user_id"], name: "index_goods_on_user_id", using: :btree

  create_table "goods_applies", force: true do |t|
    t.integer  "good_id"
    t.integer  "user_id"
    t.integer  "apply_num"
    t.text     "apply_info"
    t.string   "reviewer_ids"
    t.integer  "current_reviewer_id"
    t.boolean  "is_review_over",      default: false
    t.integer  "status",              default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "goods_applies", ["good_id"], name: "index_goods_applies_on_good_id", using: :btree
  add_index "goods_applies", ["status"], name: "index_goods_applies_on_status", using: :btree
  add_index "goods_applies", ["user_id"], name: "index_goods_applies_on_user_id", using: :btree

  create_table "leave_details", force: true do |t|
    t.integer  "user_id"
    t.integer  "leave_id"
    t.string   "data"
    t.decimal  "days",              precision: 5, scale: 1
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "kind"
    t.integer  "status",                                    default: 0
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "start_at_half_day"
    t.integer  "end_at_half_day"
  end

  add_index "leave_details", ["kind"], name: "index_leave_details_on_kind", using: :btree
  add_index "leave_details", ["leave_id"], name: "index_leave_details_on_leave_id", using: :btree
  add_index "leave_details", ["user_id"], name: "index_leave_details_on_user_id", using: :btree

  create_table "leave_statistics", force: true do |t|
    t.integer  "user_id"
    t.integer  "leave_detail_id"
    t.integer  "kind"
    t.integer  "month"
    t.integer  "year"
    t.string   "data"
    t.decimal  "total_days",      precision: 5, scale: 1
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

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
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.boolean  "admin_modify",                         default: false
  end

  add_index "leaves", ["user_id"], name: "index_leaves_on_user_id", using: :btree

  create_table "loan_goods", force: true do |t|
    t.integer  "good_id"
    t.integer  "user_id"
    t.integer  "apply_num"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "loan_info"
    t.string   "reviewer_ids"
    t.integer  "current_reviewer_id"
    t.boolean  "is_review_over",      default: false
    t.boolean  "is_consume"
    t.integer  "status",              default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "orders", force: true do |t|
    t.string   "order_key"
    t.string   "name"
    t.integer  "pre_good_id"
    t.integer  "num"
    t.float    "price",       limit: 24
    t.integer  "user_id"
    t.integer  "status",                 default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "orders", ["order_key"], name: "index_orders_on_order_key", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree

  create_table "pre_goods", force: true do |t|
    t.string   "name"
    t.integer  "num"
    t.float    "price",      limit: 24
    t.boolean  "is_consume"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "reviews", force: true do |t|
    t.integer  "applier_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "user_id"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["item_id", "item_type", "kind"], name: "index_reviews_on_item_id_and_item_type_and_kind", using: :btree
  add_index "reviews", ["item_id", "item_type"], name: "index_reviews_on_item_id_and_item_type", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

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
    t.date     "born_at"
    t.integer  "role_id"
    t.string   "department_num"
  end

  add_index "users", ["department_num"], name: "index_users_on_department_num", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_approve"], name: "index_users_on_is_approve", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
