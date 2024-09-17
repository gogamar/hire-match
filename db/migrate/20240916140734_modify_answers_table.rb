class ModifyAnswersTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference :answers, :candidate, foreign_key: true
    add_reference :answers, :job_application, null: false, foreign_key: true
  end
end
