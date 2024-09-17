class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :job, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.boolean :match

      t.timestamps
    end
  end
end
