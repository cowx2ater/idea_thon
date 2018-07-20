class AddImageToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :image, :string
  end
end
