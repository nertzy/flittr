# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from Grackle::TwitterError, :with => :twitter_error
  rescue_from User::NotAuthorized, :with => :not_authorized

  private

  def twitter_error
    render '/error/twitter', :layout => 'application', :status => 500
  end

  def not_authorized
    render '/error/not_authorized', :layout => 'application', :status => 500
  end

end
