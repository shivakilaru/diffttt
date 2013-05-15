class DiffsController < ApplicationController 
	
	def new
		@diff = Diff.new
	end
	
	def create
		@diff = current_user.diffs.build(params[:diff])
		
		if !params[:diff][:url].include? "http://" and !params[:diff][:url].empty?
			params[:diff][:url].insert(0, 'http://')
		end
		
		content = Nokogiri::HTML(open(@diff.url)).to_s()
		
		scrape = Scrape.new
		scrape = @diff.scrapes.build(:content => content)
		
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
	
	
	
	def print
		require 'open-uri'
		@response = Nokogiri::HTML(open(params[:url])).to_s().html_safe
#		@div = @response.at_css("#work").content
# 		@xpath = Nokogiri::CSS.xpath_for '#work'
# 		@textbyxpath = @response.xpath(@xpath).count
		render "response"
	end
	

		
	
	
	def test
		require 'open-uri'
		
		current_diff = Diff.find(params[:format])
		
		@site1 = Nokogiri::HTML(open(current_diff.url)).to_s()
		@site2 = Scrape.find(:last, :conditions => [ "diff_id = ?", current_diff.id]).content.to_s
		
		scrape = Scrape.new
		scrape = current_diff.scrapes.build(:content => @site1)
		if scrape.save
			puts "Scrape saved successfully"
		else
			puts "Scrape fail"
		end
		
		@output = Diffy::Diff.new(@site1, @site2, :include_plus_and_minus_in_html => true).to_s(:html)
		render "output"
	end
	
end
