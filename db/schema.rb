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

ActiveRecord::Schema.define(version: 2016_02_21_203927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pages", id: :serial, force: :cascade do |t|
    t.integer "page_type"
    t.string "path"
    t.oid "banner"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "page_id"
    t.string "title"
    t.oid "image"
    t.oid "thumbnail"
    t.text "content"
    t.string "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
