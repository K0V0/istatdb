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

ActiveRecord::Schema.define(version: 20191220122448) do

  create_table "calculators", force: :cascade do |t|
    t.text     "data"
    t.integer  "impexpcompany_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "calculators", ["impexpcompany_id"], name: "index_calculators_on_impexpcompany_id"
  add_index "calculators", ["manufacturer_id"], name: "index_calculators_on_manufacturer_id"

  create_table "changes", force: :cascade do |t|
    t.text     "change"
    t.text     "version_num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "change_typ"
  end

  create_table "global_settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "global_settings", ["thing_type", "thing_id", "var"], name: "index_global_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "global_tarics", force: :cascade do |t|
    t.string   "kncode"
    t.text     "description"
    t.text     "description2"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "good_images", force: :cascade do |t|
    t.string  "image"
    t.integer "good_id"
  end

  add_index "good_images", ["good_id"], name: "index_good_images_on_good_id"

  create_table "good_issue_files", force: :cascade do |t|
    t.string   "file"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "note"
  end

  add_index "good_issue_files", ["issue_id"], name: "index_good_issue_files_on_issue_id"

  create_table "good_issues", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "issue_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "impexpcompany_id"
  end

  add_index "good_issues", ["good_id"], name: "index_good_issues_on_good_id"
  add_index "good_issues", ["impexpcompany_id"], name: "index_good_issues_on_impexpcompany_id"
  add_index "good_issues", ["issue_id"], name: "index_good_issues_on_issue_id"

  create_table "goods", force: :cascade do |t|
    t.text     "ident"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "local_taric_id"
    t.integer  "user_id"
    t.boolean  "uncomplete"
    t.text     "uncomplete_reason"
    t.text     "note"
    t.integer  "updated_by"
    t.string   "link"
  end

  add_index "goods", ["local_taric_id"], name: "index_goods_on_local_taric_id"
  add_index "goods", ["user_id"], name: "index_goods_on_user_id"

  create_table "goods_impexpcompanies", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "impexpcompany_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "goods_impexpcompanies", ["good_id"], name: "index_goods_impexpcompanies_on_good_id"
  add_index "goods_impexpcompanies", ["impexpcompany_id"], name: "index_goods_impexpcompanies_on_impexpcompany_id"

  create_table "goods_local_tarics", force: :cascade do |t|
    t.integer  "goods_local_tarics_id"
    t.integer  "good_id"
    t.integer  "local_taric_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "goods_local_tarics", ["good_id"], name: "index_goods_local_tarics_on_good_id"
  add_index "goods_local_tarics", ["goods_local_tarics_id"], name: "index_goods_local_tarics_on_goods_local_tarics_id"
  add_index "goods_local_tarics", ["local_taric_id"], name: "index_goods_local_tarics_on_local_taric_id"

  create_table "goods_manufacturers", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "goods_manufacturers", ["good_id"], name: "index_goods_manufacturers_on_good_id"
  add_index "goods_manufacturers", ["manufacturer_id"], name: "index_goods_manufacturers_on_manufacturer_id"

  create_table "impexpcompanies", force: :cascade do |t|
    t.text     "company_name"
    t.text     "affiliated_office"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "impexpcompany_manufacturers", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "impexpcompany_id"
    t.integer  "manufacturer_id"
    t.integer  "local_taric_id"
    t.boolean  "added_or_modded_by_user"
    t.boolean  "invoices_correct"
    t.integer  "incoterm_id"
    t.integer  "trade_type_id"
  end

  add_index "impexpcompany_manufacturers", ["impexpcompany_id"], name: "index_impexpcompany_manufacturers_on_impexpcompany_id"
  add_index "impexpcompany_manufacturers", ["incoterm_id"], name: "index_impexpcompany_manufacturers_on_incoterm_id"
  add_index "impexpcompany_manufacturers", ["local_taric_id"], name: "index_impexpcompany_manufacturers_on_local_taric_id"
  add_index "impexpcompany_manufacturers", ["manufacturer_id"], name: "index_impexpcompany_manufacturers_on_manufacturer_id"
  add_index "impexpcompany_manufacturers", ["trade_type_id"], name: "index_impexpcompany_manufacturers_on_trade_type_id"

  create_table "incoterm_translations", force: :cascade do |t|
    t.integer  "incoterm_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  add_index "incoterm_translations", ["incoterm_id"], name: "index_incoterm_translations_on_incoterm_id"
  add_index "incoterm_translations", ["locale"], name: "index_incoterm_translations_on_locale"

  create_table "incoterms", force: :cascade do |t|
    t.text     "shortland"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "intertables", force: :cascade do |t|
    t.integer  "good_id"
    t.integer  "manufacturer_id"
    t.integer  "impexpcompany_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "intertables", ["good_id"], name: "index_intertables_on_good_id"
  add_index "intertables", ["impexpcompany_id"], name: "index_intertables_on_impexpcompany_id"
  add_index "intertables", ["manufacturer_id"], name: "index_intertables_on_manufacturer_id"

  create_table "issues", force: :cascade do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "season"
  end

  create_table "local_taric_translations", force: :cascade do |t|
    t.integer  "local_taric_id",  null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "description"
    t.text     "additional_info"
  end

  add_index "local_taric_translations", ["local_taric_id"], name: "index_local_taric_translations_on_local_taric_id"
  add_index "local_taric_translations", ["locale"], name: "index_local_taric_translations_on_locale"

  create_table "local_tarics", force: :cascade do |t|
    t.string   "kncode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.string   "plant"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "goods_count"
    t.text     "note"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "settings", force: :cascade do |t|
    t.string   "k"
    t.text     "v"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id"

  create_table "task_types", force: :cascade do |t|
    t.string "typ"
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "task"
    t.integer  "user_id"
    t.boolean  "done",         default: false
    t.integer  "task_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["task_type_id"], name: "index_tasks_on_task_type_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "trade_type_translations", force: :cascade do |t|
    t.integer  "trade_type_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
  end

  add_index "trade_type_translations", ["locale"], name: "index_trade_type_translations_on_locale"
  add_index "trade_type_translations", ["trade_type_id"], name: "index_trade_type_translations_on_trade_type_id"

  create_table "trade_types", force: :cascade do |t|
    t.text "type"
  end

  create_table "uom_type_translations", force: :cascade do |t|
    t.integer  "uom_type_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "full_name"
    t.text     "description"
  end

  add_index "uom_type_translations", ["locale"], name: "index_uom_type_translations_on_locale"
  add_index "uom_type_translations", ["uom_type_id"], name: "index_uom_type_translations_on_uom_type_id"

  create_table "uom_types", force: :cascade do |t|
    t.string   "uom_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "intrastat_code"
  end

  create_table "uoms", force: :cascade do |t|
    t.float    "uom"
    t.integer  "uom_multiplier"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "uom_type_id"
    t.integer  "good_id"
    t.integer  "manufacturer_id"
    t.integer  "impexpcompany_id"
  end

  add_index "uoms", ["good_id"], name: "index_uoms_on_good_id"
  add_index "uoms", ["impexpcompany_id"], name: "index_uoms_on_impexpcompany_id"
  add_index "uoms", ["manufacturer_id"], name: "index_uoms_on_manufacturer_id"
  add_index "uoms", ["uom_type_id"], name: "index_uoms_on_uom_type_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
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
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
