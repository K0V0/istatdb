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

ActiveRecord::Schema.define(version: 20161124101555) do

  create_table "goods", force: :cascade do |t|
    t.text     "ident"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "local_taric_id"
  end

  add_index "goods", ["local_taric_id"], name: "index_goods_on_local_taric_id"

  create_table "goods_impexpcompanies", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "impexpcompany_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "goods_impexpcompanies", ["good_id"], name: "index_goods_impexpcompanies_on_good_id"
  add_index "goods_impexpcompanies", ["impexpcompany_id"], name: "index_goods_impexpcompanies_on_impexpcompany_id"

  create_table "goods_manufacturers", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "uom"
    t.integer  "uom_multiplier"
  end

  add_index "goods_manufacturers", ["good_id"], name: "index_goods_manufacturers_on_good_id"
  add_index "goods_manufacturers", ["manufacturer_id"], name: "index_goods_manufacturers_on_manufacturer_id"

  create_table "impexpcompanies", force: :cascade do |t|
    t.text     "company_name"
    t.text     "affiliated_office"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "local_tarics", force: :cascade do |t|
    t.string   "kncode"
    t.string   "description"
    t.string   "additional_info"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.string   "plant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
