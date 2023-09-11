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

ActiveRecord::Schema.define(version: 2023_09_07_044850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_talents", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "talent_id", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "talent_id"], name: "index_course_talents_on_course_id_and_talent_id", unique: true
    t.index ["course_id"], name: "index_course_talents_on_course_id"
    t.index ["talent_id"], name: "index_course_talents_on_talent_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
  end

  create_table "learning_path_courses", force: :cascade do |t|
    t.bigint "learning_path_id", null: false
    t.bigint "course_id", null: false
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_learning_path_courses_on_course_id"
    t.index ["learning_path_id"], name: "index_learning_path_courses_on_learning_path_id"
    t.index ["position", "learning_path_id", "course_id"], name: "idx_position_learning_path_course", unique: true
  end

  create_table "learning_path_talents", force: :cascade do |t|
    t.bigint "learning_path_id", null: false
    t.bigint "talent_id", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_path_id", "talent_id"], name: "index_learning_path_talents_on_learning_path_id_and_talent_id", unique: true
    t.index ["learning_path_id"], name: "index_learning_path_talents_on_learning_path_id"
    t.index ["talent_id"], name: "index_learning_path_talents_on_talent_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "course_talents", "courses"
  add_foreign_key "course_talents", "users", column: "talent_id"
  add_foreign_key "courses", "users", column: "author_id"
  add_foreign_key "learning_path_courses", "courses"
  add_foreign_key "learning_path_courses", "learning_paths"
  add_foreign_key "learning_path_talents", "learning_paths"
  add_foreign_key "learning_path_talents", "users", column: "talent_id"
end
