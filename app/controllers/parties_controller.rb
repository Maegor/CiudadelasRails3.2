
class PartiesController < ApplicationController
  include PartiesHelper
     respond_to :json


  def show

  @game = Party.find(params[:id])
  @game.tick

  #TODO poner aqui toda la causitica de update
  if session[:refresh].nil?
     session[:refresh] = true
  end

  player_status = current_user.player.state

  if %w(SELECTION_TURN ACTION TURN).include?(player_status)  && %w(SELECTION_TURN ACTION TURN).include?(session[:previous_state])
    session[:refresh] = false
  else
    session[:refresh] = true
  end

  session[:previous_state] = player_status

    respond_to do |format|

      format.html{

        if @game.state == 'FINISHED'

          redirect_to (party_resumen_path(@game.id))
        else
          render :layout=> 'game_table'
        end

      }
      format.js { render :layout=> 'game_table'}

    end


  end


  def test

    @party = Party.find(1)
    respond_to do |format|

      format.json {render :json => @party}


    end


  end


  def index

    @party_list = Party.all

   end

 def resumen

   @game = Party.find(params[:party_id])
  #render :layout=> 'game_table'
 end

  def create
    
    numplayers = params[:party][:numplayer]
    name = params[:party][:name]

    party = Party.new(:numplayer => numplayers, :name => name, :current_round => 0 )


    if party.save
     party.add_player_to_party(session[:user_id])
     redirect_to party_path(party.id)

    else
      redirect_to  root_path
    end
  end


  def join

           party = Party.find( params[:id])
           #user =  User.find(session[:user_id])
           party.add_player_to_party(session[:user_id])


           if party.current_player == party.numplayer
             party.initialize_party
             party.round_initialization

           end

          redirect_to party_path(party.id)

  end

  def delete
  end

  def select_card
    session[:refresh] = true

    user = session[:user_id]
    player = current_user.player


    party_id = params[:party_id]
    party = Party.find(party_id)

    card = Card.find(params[:card_id])
    card.player_id = player.id
    card.save


    #player.change_status("WAITING_TURN")
    player.update_attribute(:state, 'WAITING_TURN' )

    #player.get_actions(card,party)


=begin
    turn = player.turn

    if turn != (party.numplayer - 1)
       party.select_next_player(player,"SELECTION_TURN")
    end
=end

    #party.select_next_player("SELECTION_TURN")
    redirect_to party_path(params[:party_id])


  end




 def end_turn

   session[:refresh] = true
    player = current_user.player
    player.action_end_turn
    player.update_attribute(:state, "WAITINGENDROUND")

    player.actions.destroy_all
    party = Party.find(player.party_id)

    redirect_to party_path(party.id)

  end






def new
   @party = Party.new

    logger.debug @party
end


def leave_game

  player = current_user.player
  player.update_attribute(:current, 'FALSE')
  current_user.update_attribute(:waiting_room_id, nil)

  redirect_to root_path

end


end
