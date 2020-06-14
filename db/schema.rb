# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_14_163405) do

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
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
