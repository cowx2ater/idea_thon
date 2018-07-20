class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :desc
      t.string :url

      t.timestamps
    end
    add_index :teams, :name
  end
end
