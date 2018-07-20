class AddColToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lion_id, :integer
  end
end
