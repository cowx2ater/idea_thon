class AddColsToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :cnt, :integer
  end
end
