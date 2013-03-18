class HomeController < ApplicationController
  
  def index




    
  end

  def get_menu

    @game = Party.find(1)

    respond_to do |format|
      format.html { redirect_to party_path(2) }
      format.js
    end


  end


end
