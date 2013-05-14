class Diff < ActiveRecord::Base
	
	attr_accessible :url, :div, :name
	
	belongs_to :user
		
	URL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	DIV_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :url,
		:presence => true
		#format: {with: URL_REGEX}
		
	validates :div,
		:presence => true
		#format: {with: DIV_REGEX}
		
end