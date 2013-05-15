class Scrape < ActiveRecord::Base
	
	attr_accessible :content
	
	belongs_to :diff

end