class UsersController < ApplicationController
	
	def new
		render :text => "Rick"
	end
	
	def index
		@users = User.all
	end
	
	
end