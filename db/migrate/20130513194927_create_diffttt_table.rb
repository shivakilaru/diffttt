class CreateDifftttTable < ActiveRecord::Migration
  def up
  	create_table :diffs do |t|
  	  t.string :user_id
  	  t.string :name
      t.string :url
      t.string :div
      
      t.timestamps
    end
    add_index :diffs, :user_id
  end

  def down
  	drop_table :diffs
  end
end
