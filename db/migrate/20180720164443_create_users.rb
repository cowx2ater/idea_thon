class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :univ
      t.string :email

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :univ
  end
end
