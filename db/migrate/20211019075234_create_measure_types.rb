class CreateMeasureTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :measure_types do |t|
      t.string :title, null: false
      t.boolean :has_target
      t.boolean :has_parent

      t.timestamps
    end
  end
end
