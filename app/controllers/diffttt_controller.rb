class DifftttController < ApplicationController 

	def index
		render "home/index"
	end
	
	def sendmsg
		comments_from_form = params['myform'][:greeting]
		render comments_from_form
	end
	
	def show
		render :text => "#{params[:message]}"
 		Resque.enqueue(Click, "james")
	end
	
	def urltest
		require 'open-uri'
		@response = Nokogiri::HTML(open(params[:url]))
		@div = @response.at_css("#work").content
		@xpath = Nokogiri::CSS.xpath_for '#work'
		@textbyxpath = @response.xpath(@xpath).count
		render "response"
	end
end
