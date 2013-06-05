class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new

  end

  def index
  end

  def create
    
    if (user = User.authenticate(params[:email],params[:password] ))
      session[:user_id] = user.id
      I18n.locale = user.lang
      redirect_to root_path
    else 
       flash[:notice]= (t 'login_menu.errors.invalid_user_pass')
      redirect_to root_path
      
    end     
  end



  def destroy
    
    session[:user_id] = nil
    redirect_to root_path
    
  end

end
