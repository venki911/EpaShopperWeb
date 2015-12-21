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

ActiveRecord::Schema.define(version: 20151221212009) do

  create_table "line_items", force: :cascade do |t|
    t.integer  "variant_id",           limit: 8
    t.integer  "product_id",           limit: 8
    t.string   "title",                limit: 255
    t.string   "description",          limit: 255
    t.string   "image_source",         limit: 255
    t.float    "price",                limit: 24
    t.integer  "quantity_missing",     limit: 4
    t.integer  "quantity_substituted", limit: 4
    t.integer  "quantity_requested",   limit: 4
    t.string   "aisle",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_collection_id",   limit: 4
  end

  create_table "shop_collections", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "orders_count",      limit: 4
    t.integer  "items_count",       limit: 4
    t.integer  "time_taken",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shopper_report_id", limit: 4
    t.string   "start_time",        limit: 255
  end

  create_table "shopper_reports", force: :cascade do |t|
    t.string   "shopper_name", limit: 255
    t.integer  "orders_count", limit: 4
    t.integer  "items_count",  limit: 4
    t.integer  "total_time",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppers", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                       default: false
  end

end
