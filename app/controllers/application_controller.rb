class ApplicationController < ActionController::Base

  protect_from_forgery
  include SessionHelper
  
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  
  def home
	render "home/index"
  end
  
end
