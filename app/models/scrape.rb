class Scrape < ActiveRecord::Base
	
	attr_accessible :content, :change
	
	belongs_to :diff

end