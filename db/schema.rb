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

ActiveRecord::Schema.define(version: 2021_11_01_083817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_types", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "has_members", default: false
    t.boolean "is_active", default: false
    t.boolean "is_target", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actors", force: :cascade do |t|
    t.bigint "actor_type_id", null: false
    t.string "code", null: false
    t.string "title", null: false
    t.text "description"
    t.text "activity_summary"
    t.string "url"
    t.decimal "population"
    t.decimal "gdp"
    t.boolean "private", default: true
    t.boolean "draft", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.index ["actor_type_id"], name: "index_actors_on_actor_type_id"
    t.index ["created_by_id"], name: "index_actors_on_created_by_id"
    t.index ["updated_by_id"], name: "index_actors_on_updated_by_id"
  end

  create_table "bookmarks", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.json "view", null: false
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.text "title"
    t.string "short_title"
    t.text "description"
    t.string "url"
    t.integer "taxonomy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.integer "manager_id"
    t.string "reference"
    t.boolean "user_only"
    t.integer "updated_by_id"
    t.integer "parent_id"
    t.date "date"
    t.integer "created_by_id"
    t.index ["draft"], name: "index_categories_on_draft"
    t.index ["manager_id"], name: "index_categories_on_manager_id"
    t.index ["taxonomy_id"], name: "index_categories_on_taxonomy_id"
  end

  create_table "due_dates", id: :serial, force: :cascade do |t|
    t.integer "indicator_id"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.index ["draft"], name: "index_due_dates_on_draft"
    t.index ["indicator_id"], name: "index_due_dates_on_indicator_id"
  end

  create_table "framework_frameworks", id: :serial, force: :cascade do |t|
    t.integer "framework_id"
    t.integer "other_framework_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "framework_taxonomies", id: :serial, force: :cascade do |t|
    t.integer "framework_id", null: false
    t.integer "taxonomy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.index ["framework_id"], name: "index_framework_taxonomies_on_framework_id"
    t.index ["taxonomy_id"], name: "index_framework_taxonomies_on_taxonomy_id"
  end

  create_table "frameworks", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.string "short_title"
    t.text "description"
    t.boolean "has_indicators"
    t.boolean "has_measures"
    t.boolean "has_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "indicators", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.integer "manager_id"
    t.integer "frequency_months"
    t.date "start_date"
    t.boolean "repeat", default: false
    t.date "end_date"
    t.string "reference"
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.index ["created_at"], name: "index_indicators_on_created_at"
    t.index ["draft"], name: "index_indicators_on_draft"
    t.index ["manager_id"], name: "index_indicators_on_manager_id"
  end

  create_table "measure_categories", id: :serial, force: :cascade do |t|
    t.integer "measure_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "measure_indicators", id: :serial, force: :cascade do |t|
    t.integer "measure_id"
    t.integer "indicator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "measure_types", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "has_target", default: true
    t.boolean "has_parent", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "measures", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.text "description"
    t.text "target_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.text "outcome"
    t.text "indicator_summary"
    t.text "target_date_comment"
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.bigint "measure_type_id"
    t.bigint "parent_id"
    t.string "code"
    t.string "comment"
    t.string "url"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string "date_comment"
    t.string "target_comment"
    t.string "status_comment"
    t.string "reference_ml"
    t.string "reference_landbased_ml"
    t.boolean "has_reference_landbased_ml"
    t.string "status_lbs_protocol"
    t.decimal "amount"
    t.string "amount_comment"
    t.boolean "private", default: true
    t.index ["draft"], name: "index_measures_on_draft"
    t.index ["measure_type_id"], name: "index_measures_on_measure_type_id"
    t.index ["parent_id"], name: "index_measures_on_parent_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "menu_title"
    t.boolean "draft", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.boolean "private", default: true
    t.index ["draft"], name: "index_pages_on_draft"
    t.index ["private"], name: "index_pages_on_private"
  end

  create_table "progress_reports", id: :serial, force: :cascade do |t|
    t.integer "indicator_id"
    t.integer "due_date_id"
    t.text "title"
    t.text "description"
    t.string "document_url"
    t.boolean "document_public"
    t.boolean "draft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.index ["due_date_id"], name: "index_progress_reports_on_due_date_id"
    t.index ["indicator_id"], name: "index_progress_reports_on_indicator_id"
  end

  create_table "recommendation_categories", id: :serial, force: :cascade do |t|
    t.integer "recommendation_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "recommendation_indicators", id: :serial, force: :cascade do |t|
    t.integer "recommendation_id"
    t.integer "indicator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.index ["indicator_id"], name: "index_recommendation_indicators_on_indicator_id"
    t.index ["recommendation_id"], name: "index_recommendation_indicators_on_recommendation_id"
  end

  create_table "recommendation_measures", id: :serial, force: :cascade do |t|
    t.integer "recommendation_id"
    t.integer "measure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
    t.index ["measure_id"], name: "index_recommendation_measures_on_measure_id"
    t.index ["recommendation_id"], name: "index_recommendation_measures_on_recommendation_id"
  end

  create_table "recommendation_recommendations", id: :serial, force: :cascade do |t|
    t.integer "recommendation_id"
    t.integer "other_recommendation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "recommendations", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.boolean "accepted"
    t.text "response"
    t.text "reference", null: false
    t.text "description"
    t.integer "updated_by_id"
    t.integer "framework_id"
    t.integer "created_by_id"
    t.index ["draft"], name: "index_recommendations_on_draft"
    t.index ["framework_id"], name: "index_recommendations_on_framework_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "friendly_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "taxonomies", id: :serial, force: :cascade do |t|
    t.text "title", null: false
    t.boolean "tags_measures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allow_multiple"
    t.boolean "tags_users"
    t.boolean "has_manager", default: false
    t.integer "priority"
    t.boolean "is_smart"
    t.integer "groups_measures_default"
    t.integer "groups_recommendations_default"
    t.integer "updated_by_id"
    t.integer "parent_id"
    t.boolean "has_date"
    t.integer "framework_id"
    t.integer "created_by_id"
    t.index ["framework_id"], name: "index_taxonomies_on_framework_id"
  end

  create_table "user_categories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id"
  end

  create_table "user_roles", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.integer "updated_by_id"
    t.boolean "allow_password_change", default: true
    t.integer "created_by_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "actors", "actor_types"
  add_foreign_key "framework_frameworks", "frameworks"
  add_foreign_key "framework_frameworks", "frameworks", column: "other_framework_id"
  add_foreign_key "framework_taxonomies", "frameworks"
  add_foreign_key "framework_taxonomies", "taxonomies"
  add_foreign_key "measures", "measure_types"
  add_foreign_key "measures", "measures", column: "parent_id"
  add_foreign_key "recommendation_indicators", "indicators"
  add_foreign_key "recommendation_indicators", "recommendations"
  add_foreign_key "recommendation_recommendations", "recommendations"
  add_foreign_key "recommendation_recommendations", "recommendations", column: "other_recommendation_id"
  add_foreign_key "recommendations", "frameworks"
  add_foreign_key "taxonomies", "frameworks"
end
