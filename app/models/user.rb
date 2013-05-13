class User < ActiveRecord::Base
	
	attr_accessible :email, :name, :password, :password_confirmation
	
	has_secure_password
	
	has_many :diffs
	
	before_save { |user| user.email = email.downcase }
	
	before_save :create_remember_token
	
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	
	#-----------Validators----------#
	
	validates :name, :presence => true, length: {maximum: 50}
	
	
	
	validates :email, 
				:presence => true, 
				format: {with: EMAIL_REGEX}, 
				uniqueness: {case_sensitive: false}
	
	validates :password,
				presence: true,
				length: {minimum: 6}
	
	validates :password_confirmation,
				presence: true
				
		
	#-----------Private Methods for Sessions----------#
	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
			puts "token value is "   #####UTILITY####
			puts self.remember_token    #####UTILITY####
		end			
						
				
end