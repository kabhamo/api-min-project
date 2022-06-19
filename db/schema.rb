# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_19_090055) do
  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "favoriteProgrammingLanguage"
    t.integer "activeTaskCount", default: 0
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "type"
    t.string "status"
    t.string "description"
    t.string "size"
    t.string "course"
    t.date "dueDate"
    t.string "details"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
  end

  add_foreign_key "tasks", "people", column: "owner_id"
end
