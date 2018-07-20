class AddCntToVote < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :cnt, :integer
    add_index :votes, :cnt
  end
end
