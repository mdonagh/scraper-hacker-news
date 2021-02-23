class AddRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.references :link
      t.integer :page_rank
      t.timestamps
    end
  end
end
