class ConsistentNullConstraints < ActiveRecord::Migration[6.1]
  TABLES = %i[
    actor_categories
    actors
    bookmarks
    categories
    due_dates
    framework_taxonomies
    indicators
    measures
    memberships
    pages
    progress_reports
    recommendation_categories
    recommendation_indicators
    recommendation_measures
    recommendations
    taxonomies
    user_roles
    users
  ]

  def up
    TABLES.each do |table_name|
      change_column table_name, :created_by_id, :bigint, null: false
    end

    change_column :actor_measures, :updated_by_id, :bigint, null: true
    change_column :measure_actors, :updated_by_id, :bigint, null: true
  end

  def down
    TABLES.each do |table_name|
      change_column table_name, :created_by_id, :bigint, null: true
    end

    change_column :measure_actors, :updated_by_id, :bigint, null: false
    change_column :actor_measures, :updated_by_id, :bigint, null: false
  end
end
