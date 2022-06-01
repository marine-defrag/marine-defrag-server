class AddRelationshiptypeIdToActorMeasures < ActiveRecord::Migration[6.1]
  def change
    add_column :actor_measures, :relationshiptype_id, :bigint
  end
end
