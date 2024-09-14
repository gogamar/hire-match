class CreateModelsAndAddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false

    create_table :companies do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :candidates do |t|
      t.string :name
      t.string :surname
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.references :company, foreign_key: true

      t.timestamps
    end

    create_table :interviews do |t|
      t.string :name
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end

    create_table :questions do |t|
      t.integer :number
      t.text :content
      t.references :interview, null: false, foreign_key: true

      t.timestamps
    end

    create_table :answers do |t|
      t.text :content
      t.text :reaction
      t.references :question, null: false, foreign_key: true
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
