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

ActiveRecord::Schema[7.0].define(version: 2023_04_30_060337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags", default: [], array: true
    t.text "equipment"
    t.string "picture"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.text "contact_info"
    t.text "medical_info"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.string "first_name"
    t.string "last_name"
    t.text "diagnosis"
  end

  create_table "set_configs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "weight"
    t.integer "time_seconds"
    t.integer "distance"
    t.integer "speed"
    t.integer "incline"
    t.integer "pulse"
    t.integer "rubber_support"
    t.boolean "hypoxia"
    t.integer "pauses_count"
    t.text "other_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_results", force: :cascade do |t|
    t.string "set_comp_code"
    t.bigint "patients_id", null: false
    t.bigint "trainings_id", null: false
    t.bigint "set_configs_id", null: false
    t.text "self_perception"
    t.text "assesment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patients_id"], name: "index_set_results_on_patients_id"
    t.index ["set_configs_id"], name: "index_set_results_on_set_configs_id"
    t.index ["trainings_id"], name: "index_set_results_on_trainings_id"
  end

  create_table "sets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "exercise_id", null: false
    t.integer "reps"
    t.integer "duration"
    t.integer "set_rest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_sets_on_exercise_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.string "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sets", default: [], array: true
    t.integer "rests", default: [], array: true
    t.integer "counts", default: [], array: true
    t.bigint "set_configs", default: [], array: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "set_results", "patients", column: "patients_id"
  add_foreign_key "set_results", "set_configs", column: "set_configs_id"
  add_foreign_key "set_results", "trainings", column: "trainings_id"
  add_foreign_key "sets", "exercises"
end
