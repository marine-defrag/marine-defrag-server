class AddUniqueConstraintToJoinTables < ActiveRecord::Migration[6.1]
  def change
    add_index :actor_categories, [:actor_id, :category_id], unique: true
    add_index :actor_measures, [:actor_id, :measure_id], unique: true
    add_index :measure_actors, [:measure_id, :actor_id], unique: true
    add_index :measure_categories, [:measure_id, :category_id], unique: true
    add_index :measure_resources, [:measure_id, :resource_id], unique: true
    add_index :memberships, [:member_id, :memberof_id], unique: true
  end
end
