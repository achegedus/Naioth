# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "default"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_account_session, :current_account

  private
    def current_account_session
      return @current_account_session if defined?(@current_account_session)
      @current_account_session = AccountSession.find
    end

    def current_account
      return @current_account if defined?(@current_account)
      @current_account = current_account_session && current_account_session.record
    end

    def require_account
      unless current_account
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_account_session_url
        return false
      end
    end

    def require_no_account
      if current_account
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
