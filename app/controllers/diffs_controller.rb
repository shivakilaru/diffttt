class DiffsController < ApplicationController 
	
	def new
		@diff = Diff.new
	end
	
	def create
		if !params[:diff][:url].include? "http://"
			params[:diff][:url].insert(0, 'http://')
		end
		@diff = current_user.diffs.build(params[:diff])
		
		respond_to do |format|
		  if @diff.save
			format.html { redirect_to @diff, notice: 'User was successfully created.' }
			format.json { render json: @diff, status: :created, location: @user }
		  else
			format.html { render action: "new" }
			format.json { render json: @diff.errors, status: :unprocessable_entity }
		  end
		end
	end
	
	def show
    	@diff = Diff.find(params[:id])
    	
    	respond_to do |format|
    		format.html
    		format.json {render json: @user}
    	end
    end
	
	def index
		@diffs = Diff.where(["user_id = ?", current_user.id])
	end
	
	def sendmsg
		comments_from_form = params['myform'][:greeting]
		render comments_from_form
	end
	
# 	def show
# 		render :text => "#{params[:message]}"
#  		Resque.enqueue(Click)
# 	end
	
	def urltest
		require 'open-uri'
		@response = Nokogiri::HTML(open(params[:url]))
#		@div = @response.at_css("#work").content
# 		@xpath = Nokogiri::CSS.xpath_for '#work'
# 		@textbyxpath = @response.xpath(@xpath).count
		render "response"
	end
end
