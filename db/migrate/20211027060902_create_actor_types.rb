class CreateActorTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :actor_types do |t|
      t.string :title, null: false
      t.boolean :has_members
      t.boolean :is_active
      t.boolean :is_target

      t.timestamps
    end
  end
end
