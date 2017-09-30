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

ActiveRecord::Schema.define(version: 20170930180902) do

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

  create_table "households", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "list_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "list_items", ["item_id"], name: "index_list_items_on_item_id"
  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id"

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_owner_id"
    t.string   "list_owner_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "lists", ["list_owner_type", "list_owner_id"], name: "index_lists_on_list_owner_type_and_list_owner_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rooms", ["owner_type", "owner_id"], name: "index_rooms_on_owner_type_and_owner_id"

end
