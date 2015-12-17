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

ActiveRecord::Schema.define(version: 20151217195109) do

  create_table "line_items", force: :cascade do |t|
    t.integer  "variant_id"
    t.integer  "product_id"
    t.string   "title"
    t.string   "description"
    t.string   "image_source"
    t.float    "price"
    t.boolean  "complete"
    t.integer  "quantity_missing"
    t.integer  "quantity_substituted"
    t.integer  "quantity_requested"
    t.string   "aisle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_collection_id"
  end

  create_table "shop_collections", force: :cascade do |t|
    t.string   "name"
    t.string   "orders_count"
    t.string   "aisle_count"
    t.integer  "time_in_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shopper_report_id"
  end

  create_table "shopper_reports", force: :cascade do |t|
    t.string   "shopper_name"
    t.integer  "orders_count"
    t.integer  "line_items_count"
    t.integer  "total_time_in_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppers", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
