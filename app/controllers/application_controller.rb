class ApplicationController < ActionController::Base

  protect_from_forgery

before_filter :set_locale,:authorize

 private
 def set_locale
   #f session[:user_id]

   if cookies[:lang].nil?
   cookies[:lang] = {
   :value =>'es',
   :domain => 'localhost'
   }
   end
    I18n.locale = cookies[:lang]
   #end
  end

  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
  end
  protected
  def authorize

    unless User.find_by_id(session[:user_id])
      redirect_to root_path
    end


  end



end
