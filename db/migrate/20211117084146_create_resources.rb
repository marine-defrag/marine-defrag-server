class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.text :description
      t.text :url
      t.belongs_to :type, null: false, foreign_key: {to_table: "resourcetypes"}
      t.boolean :private, default: true
      t.boolean :draft, default: true
      t.datetime :publication_date
      t.datetime :access_date
      t.text :status

      t.timestamps
    end

    change_table :actor_measures do |t|
      t.belongs_to :source, null: true, foreign_key: {to_table: "resources"}
    end
  end
end
