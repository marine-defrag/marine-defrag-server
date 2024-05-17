class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.text :subject
      t.text :content
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.datetime :sent_at

      t.timestamps
    end
  end
end
