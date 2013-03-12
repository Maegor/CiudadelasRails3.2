class SessionsController < ApplicationController

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
       flash[:notice]=  "Invalid user/pass name combination"
      redirect_to root_path
      
    end     
  end



  def destroy
    
    session[:user_id] = nil
    redirect_to root_path
    
  end

end
