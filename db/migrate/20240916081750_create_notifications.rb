class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :message
      t.integer :status, default: 0
      t.string :notification_type

      t.timestamps
    end
  end
end
