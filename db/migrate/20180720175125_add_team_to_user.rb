class AddTeamToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :team, foreign_key: true
  end
end
