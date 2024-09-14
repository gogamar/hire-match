class CreateJoinTableJobsCandidates < ActiveRecord::Migration[7.1]
  def change
    create_join_table :jobs, :candidates do |t|
      t.index :job_id
      t.index :candidate_id
      t.timestamps
    end
  end
end
