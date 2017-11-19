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

ActiveRecord::Schema.define(version: 20171115070510) do

  create_table "bills", force: :cascade do |t|
    t.string   "company"
    t.string   "utility"
    t.integer  "amount"
    t.date     "due_date"
    t.integer  "account_number"
    t.integer  "household_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bills", ["household_id"], name: "index_bills_on_household_id"

  create_table "chores", force: :cascade do |t|
    t.string   "task"
    t.date     "due_date"
    t.integer  "member_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "completed",  default: false
  end

  add_index "chores", ["member_id"], name: "index_chores_on_member_id"

  create_table "households", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "password_digest"
  end

  create_table "invitees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "household_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "invitees", ["household_id"], name: "index_invitees_on_household_id"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.integer  "list_id"
    t.integer  "item_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "brand"
    t.string   "info"
  end

  add_index "list_items", ["item_id"], name: "index_list_items_on_item_id"
  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id"

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "member_id"
  end

  add_index "lists", ["member_id"], name: "index_lists_on_member_id"

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "family_title"
    t.integer  "monthly_income",    default: 0
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "head_of_household", default: false
    t.integer  "household_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "members", ["household_id"], name: "index_members_on_household_id"

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "room_items", force: :cascade do |t|
    t.integer  "stock"
    t.integer  "room_id"
    t.integer  "item_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "request",    default: false
    t.integer  "threshold"
  end

  add_index "room_items", ["item_id"], name: "index_room_items_on_item_id"
  add_index "room_items", ["room_id"], name: "index_room_items_on_room_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "member_id"
    t.integer  "household_id"
  end

  add_index "rooms", ["household_id"], name: "index_rooms_on_household_id"
  add_index "rooms", ["member_id"], name: "index_rooms_on_member_id"

end
