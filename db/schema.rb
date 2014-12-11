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

ActiveRecord::Schema.define(version: 20141203163011) do

  create_table "kit_items", force: true do |t|
    t.integer  "reagent_id"
    t.string   "item_name"
    t.string   "item_lot_no"
    t.string   "item_cat_no"
    t.date     "item_expiration_date"
    t.decimal  "item_storage_temp",     precision: 10, scale: 0
    t.string   "item_storage_location"
    t.date     "last_date_updated"
    t.boolean  "is_item_used",                                   default: false
    t.date     "date_opened"
    t.string   "used_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "reagent_id"
    t.integer  "number"
    t.string   "item_lot_no"
    t.date     "received_date"
    t.date     "expiration_date"
    t.date     "opened_date"
    t.string   "opened_by"
    t.string   "for_study"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "request_id"
    t.string   "order_no"
    t.string   "catalog_no"
    t.decimal  "unit_price",               precision: 10, scale: 0
    t.string   "manufacturer"
    t.string   "supplier"
    t.decimal  "ordered_amount",           precision: 10, scale: 0
    t.boolean  "on_back_order"
    t.decimal  "back_order_amount",        precision: 10, scale: 0, default: 0
    t.decimal  "back_order_delivery_date", precision: 10, scale: 0
    t.date     "ordered_date"
    t.date     "last_date_updated"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reagents", force: true do |t|
    t.integer  "order_id"
    t.decimal  "delivered_amount",  precision: 10, scale: 0
    t.string   "item_lot_no"
    t.string   "item_cat_no"
    t.string   "storage_temp_kit"
    t.string   "storage_location"
    t.decimal  "amount_left",       precision: 10, scale: 0
    t.date     "received_date"
    t.date     "expiration_date"
    t.string   "status"
    t.date     "last_date_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.string   "reagent_name"
    t.string   "requested_by"
    t.string   "requested_for_study"
    t.decimal  "requested_amount",    precision: 10, scale: 0
    t.date     "requested_date"
    t.string   "status"
    t.date     "last_update_date"
    t.string   "catalog_no"
    t.string   "manufacturer"
    t.string   "supplier"
    t.boolean  "is_reagent_kit"
    t.integer  "child_items_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", force: true do |t|
    t.string   "study_name"
    t.string   "study_number"
    t.date     "study_start_date"
    t.date     "study_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
