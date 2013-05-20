class AddChangeColumnToScrapes < ActiveRecord::Migration
  def change
  	add_column :scrapes, :change, :string
  end
end
