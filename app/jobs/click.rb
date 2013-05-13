module Click
	@queue = :clicks
	
	def self.perform(lastname)
		puts "Rick #{lastname}!"
	end
end