class UpdateUniqueIndexOnActorMeasures < ActiveRecord::Migration[7.2]
  def change
    remove_index :actor_measures, column: [:actor_id, :measure_id]

    add_index :actor_measures, [:actor_id, :measure_id, :date_start], unique: true, name: 'index_actor_measures_on_actor_measure_date_start'
  end
end
