module Scraper
	
	require 'open-uri'

	@queue = :scrapes
	
	def self.perform()
		difflist = Diff.all

		difflist.each do |d|
			puts "updating record for diff of " + d.url
			html = Nokogiri::HTML(open(d.url)).to_s()
			scrape = Scrape.new
			scrape = d.scrapes.build(:content => html)
		end
	end
end