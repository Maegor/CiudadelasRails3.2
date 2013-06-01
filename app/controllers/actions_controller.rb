class ActionsController < ApplicationController



  def action
    action_array = params[:path].split('/') + params[:cards].to_a + params[:opponent].to_a

    #player = Player.find_by_user_id(session[:user_id])

     current_user.player.call_action(action_array)
    redirect_to  party_path(params[:party_id])



  end



end
