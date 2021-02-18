class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :content
      t.string :url
      t.integer :rank
      t.timestamps
    end
  end
end
