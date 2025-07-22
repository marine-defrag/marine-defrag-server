class AddPasswordChangedAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :password_changed_at, :datetime
  end
end
