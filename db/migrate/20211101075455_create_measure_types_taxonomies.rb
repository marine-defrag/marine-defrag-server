class CreateMeasureTypesTaxonomies < ActiveRecord::Migration[6.1]
  def change
    create_table :measure_types_taxonomies do |t|
      t.belongs_to :measure_type, foreign_key: true, index: true, null: false
      t.belongs_to :taxonomy, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
