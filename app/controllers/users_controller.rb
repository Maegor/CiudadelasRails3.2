class UsersController < ApplicationController


  
  def index
  end

  def testt

    @user = User.all

  end



  def show
    current_user
  end

  def create
    
    
   
    @user = User.new(params[:user])
    
    #@player = Player.new(:coins => 4, :numdistricts => 0, :age => 0)
     
      
    if @user.save 
         #@player.user_id = @user.id
        # @player.save
         
         redirect_to root_path
      
     else 
       render :action => 'new'
     end
       
  
    
    
  end
  
  def new

    @user = User.new
    
  end


  def update

    lang = params[:user][:lang]
    current_user.update_attribute(:lang,lang)
    I18n.locale = lang
    redirect_to user_path(current_user)

  end
  

end
