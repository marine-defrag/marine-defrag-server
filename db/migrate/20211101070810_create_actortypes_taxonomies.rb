class CreateActortypesTaxonomies < ActiveRecord::Migration[6.1]
  def change
    create_table :actortypes_taxonomies do |t|
      t.belongs_to :actor_type, foreign_key: true, index: true, null: false
      t.belongs_to :taxonomy, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
