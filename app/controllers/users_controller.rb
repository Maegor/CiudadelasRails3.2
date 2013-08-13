class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:create,:new]
  
  def index
  end

  def testt

    @user = User.all

  end



  def show
   @user =  current_user
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


    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

   render :action => 'show'

   ## respond_to do |format|
     # format.html
      #format.js

   # end

  end
  

end
