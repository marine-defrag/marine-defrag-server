class AddIsArchivedToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :archived_at, :datetime, null: true, index: true
    add_column :users, :is_archived, :boolean, null: false, default: false
  end
end
