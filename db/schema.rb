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

ActiveRecord::Schema.define(version: 2021_07_04_162805) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "article_lecture_insertions", force: :cascade do |t|
    t.integer "number"
    t.bigint "article_id"
    t.bigint "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_lecture_insertions_on_article_id"
    t.index ["lecture_id"], name: "index_article_lecture_insertions_on_lecture_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.text "preview"
    t.string "preview_image_url"
    t.bigint "category_id"
    t.text "preview_code"
    t.boolean "documentation", default: true
    t.boolean "active", default: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["deleted_at"], name: "index_articles_on_deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_lectures", id: false, force: :cascade do |t|
    t.bigint "language_id"
    t.bigint "lecture_id"
    t.index ["language_id"], name: "index_languages_lectures_on_language_id"
    t.index ["lecture_id"], name: "index_languages_lectures_on_lecture_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.text "body"
    t.bigint "workshop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.text "preview"
    t.string "preview_image_url"
    t.boolean "active", default: false
    t.boolean "prologue", default: false
    t.bigint "level_id"
    t.boolean "printable", default: false
    t.boolean "slides", default: false
    t.boolean "cc_license", default: true
    t.text "license"
    t.bigint "author_id"
    t.boolean "community", default: true
    t.index ["author_id"], name: "index_lectures_on_author_id"
    t.index ["deleted_at"], name: "index_lectures_on_deleted_at"
    t.index ["level_id"], name: "index_lectures_on_level_id"
    t.index ["workshop_id"], name: "index_lectures_on_workshop_id"
  end

  create_table "lectures_subjects", id: false, force: :cascade do |t|
    t.bigint "lecture_id"
    t.bigint "subject_id"
    t.index ["lecture_id"], name: "index_lectures_subjects_on_lecture_id"
    t.index ["subject_id"], name: "index_lectures_subjects_on_subject_id"
  end

  create_table "lectures_tools", id: false, force: :cascade do |t|
    t.bigint "lecture_id"
    t.bigint "tool_id"
    t.index ["lecture_id"], name: "index_lectures_tools_on_lecture_id"
    t.index ["tool_id"], name: "index_lectures_tools_on_tool_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects_showcases", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "showcase_id", null: false
    t.index ["project_id"], name: "index_projects_showcases_on_project_id"
    t.index ["showcase_id"], name: "index_projects_showcases_on_showcase_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tools", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "parent", default: false
    t.boolean "volunteer", default: false
    t.boolean "student", default: false
    t.boolean "admin", default: false
    t.datetime "deleted_at"
    t.boolean "translator", default: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workshops", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "image_url"
    t.boolean "active", default: false
    t.index ["deleted_at"], name: "index_workshops_on_deleted_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "categories"
  add_foreign_key "lectures", "workshops"
end
