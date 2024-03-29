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

ActiveRecord::Schema.define(version: 2023_07_29_184530) do

  create_table "editor_images", force: :cascade do |t|
    t.string "file"
    t.string "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "page_type", null: false
    t.string "path", limit: 255, null: false
    t.string "banner", limit: 255
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_order", default: 0
    t.integer "page_sub_type", default: 0
    t.text "title"
    t.boolean "hide", default: false
    t.index ["path"], name: "index_pages_on_path", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "image", limit: 255
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", limit: 255
    t.integer "page_id"
    t.decimal "price"
    t.integer "quantity", default: 0
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
