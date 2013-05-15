class CreateTableForScrapes < ActiveRecord::Migration
  def up
  	create_table :scrapes do |t|
  		t.string :diff_id
  		t.string :content
  		
  		t.timestamps
  	end
  end

  def down
  	drop_table :scrapes
  end
end
