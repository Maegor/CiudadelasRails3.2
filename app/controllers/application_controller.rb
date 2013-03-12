class ApplicationController < ActionController::Base
  protect_from_forgery

before_filter :set_locale

 private
 def set_locale
   if session[:user_id]
    I18n.locale = current_user.lang
   end
  end

  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end



end
