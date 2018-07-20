class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :team, foreign_key: true
      t.datetime :crawl_date

      t.timestamps
    end
  end
end
