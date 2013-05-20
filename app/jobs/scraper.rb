module Scraper
	
	require 'open-uri'

	@queue = :scrapes
	
	def self.perform()
		difflist = Diff.all

		difflist.each do |d|
			puts "updating record for diff of " + d.url
					site1 = Nokogiri::HTML(open(d.url))
		
			site1 = site1.css(d.div).first.to_s
		
			site2 = Scrape.find(:last, :conditions => [ "diff_id = ?", d.id])
		
			if site2.nil?
				site2 = site1
				newdiff = true
			else
				site2 = site2.content.to_s
				newdiff = false
			end
		
			if !newdiff
				puts "UTILITYMSG: newdiff is false" 
				output = Diffy::Diff.new(site2, site1, :include_plus_and_minus_in_html => true, :allow_empty_diff => true).to_s(:html)
			else
				puts "UTILITYMSG: newdiff is true" 
				output = Diffy::Diff.new(site2, site1, :include_plus_and_minus_in_html => true).to_s(:html)
			end
		
			scrape = Scrape.new
			scrape = d.scrapes.build(:content => site1, :change => output)
			if scrape.save
				puts "UTILITYMSG: Scrape saved successfully"
			else
				puts "UTILITYMSG: Scrape fail"
			end
		end
	end
end