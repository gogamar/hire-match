class SetMatchDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :likes, :match, from: nil, to: false
  end
end
