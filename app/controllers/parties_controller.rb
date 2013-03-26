
class PartiesController < ApplicationController
  include PartiesHelper
     respond_to :json


  def show

  @game = Party.find(params[:id])
  @game.tick

  if session[:refresh].nil?
    session[:refresh] = true

  end



    respond_to do |format|

      format.html{
        if @game.state == 'FINISHED'
          redirect_to (party_resumen_path(@game.id))
        end
      }
      format.js

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


  def  take_coins

   player = Player.find_by_user_id(session[:user_id])
   player.add_coins(2)
   #player.change_status("ACTION")
   player.update_attribute(:state, 'ACTION')

   card = player.cards.where(:type => "Personaje").first
   party = player.party

   round = player.party.current_round
   ["TAKEGOLD","TAKEDISTRICTS"].each do |name|
     action = player.actions.where(:name => name, :round => round).first
     action.quantity -= 1
     action.save
   end

   #player.get_actions(card,party)
   player.get_actions()
   redirect_to party_path(params[:party_id])



  end






  def select_district

    player = Player.find_by_user_id(session[:user_id])
    #player.change_status ("ACTION")

    player.update_attribute(:state, 'ACTION')

    card = Card.find(params[:card_id])
    card.update_owner(player.id)
    card.update_status ("enMano")
    card.save


    party = Party.find(params[:party_id])
    party.reorder_cards()


    round = player.party.current_round
    action = player.actions.where(:name => "SELECTDISTRICT", :round => round).first
    action.quantity -= 1
    action.save

    #player.get_actions(card,party)
    player.get_actions()
    redirect_to party_path(params[:party_id])
  end


  def build_district

    card = Card.find(params[:card_id])
    card.update_status("enJuego")
    card.save

    player = Player.find(card.player_id)
   # player.change_status("WAITINGENDROUND")
    player.coins = player.coins - card.cost
    player.numdistricts += 1
    player.save


    round = player.party.current_round
    action = player.actions.where(:name => "CONSTRUIR", :round => round).first
    action.quantity -= 1
    action.save




    redirect_to party_path(card.party_id)


  end

  def end_turn


    player = current_user.player
    player.action_end_turn
    player.update_attribute(:state, "WAITINGENDROUND")

    player.actions.destroy_all
    party = Party.find(player.party_id)

    redirect_to party_path(party.id)

  end



  #El personaje elegido es asesinado si un jugador lo tiene en la mano
  #entonces dicho jugador pierde el turno.
  def murder

    player = Player.find(session[:user_id])

    party =  Party.find(params[:party_id])
    card = Card.find(params[:card_id])
    card.murdered="Y"
    card.save

    if card.player_id

      murdered = Player.find(card.player_id)
      #murdered.murdered="Y"
      #murdered.change_status("WAITINGENDROUND")
      murdered.update_attributes(:murdered => 'FALSE', :state => "WAITINGENDROUND" )
      #murdered.save

    end


    round = player.party.current_round
    action = player.actions.where(:name => "MURDER", :round => round).first
    action.quantity -= 1
    action.save


    redirect_to party_path(params[:party_id])



  end


  def steal

    player = Player.find_by_user_id(session[:user_id])
    logger.debug session[:user_id]
    logger.debug player.id

    party =  Party.find(params[:party_id])
    card = Card.find(params[:card_id])
    card.stolen = "Y"
    card.save

    if card.player_id

      stolen_player = Player.find(card.player_id)
      stolen_player.stolen = "Y"
      stolen_player.save

    end


    round = player.party.current_round
    action = player.actions.where(:name => "STEAL", :round => round).first
    action.quantity -= 1
    action.save


    redirect_to party_path(params[:party_id])




  end



  def change_with_maze



    player = Player.find(session[:user_id])
    party =  Party.find(params[:party_id])

    round = party.current_round
    action = player.actions.where(:name => "CHANGECARDS", :round => round).first
    action.quantity -= 1
    action.save

    player.actions.create(:name => "CHANGEWITHMAZE", :player_id => player.id, :round => party.current_round, :quantity => 1)

    redirect_to party_path(params[:party_id])

  end

  def change_with_player
    player = Player.find(session[:user_id])
    party =  Party.find(params[:party_id])

    round = party.current_round
    action = player.actions.where(:name => "CHANGECARDS", :round => round).first
    action.quantity -= 1
    action.save

    player.actions.create(:name => "CHANGEWITHPLAYER", :player_id => player.id, :round => party.current_round, :quantity => 1)

    redirect_to party_path(params[:party_id])



  end





def change_cards

  cards = params[:cards]
  player = Player.find(session[:user_id])
  party = Party.find(params[:party_id])
   puts("########################3")
   puts(cards)
   puts (params[:party_id])


  last_position = party.cards.where("type = 'Distrito' AND state='enMazo'").order("position ASC").last.position + 1
  puts(last_position)

  unless cards.nil?

    cards.each do |id|
      card = party.cards.find(id)
      card.state = "enMazo"
      card.position = last_position
      card.save
      last_position += 1
    end

    card_to_take = party.cards.where("type = 'Distrito' AND state='enMazo'").order("position ASC").limit(cards.size)

    card_to_take.each do |card|
      card.state = "enMano"
      card.player_id = player.id
      card.id
      card.save

    end

  end

  round = party.current_round
  action = player.actions.where(:name => "CHANGEWITHMAZE", :round => round).first
  action.quantity -= 1
  action.save


  redirect_to party_path(params[:party_id])


end



def exchange_cards
  opponent = Player.find(params[:opponent])
  puts ('#############')
  puts(opponent.id)

  player = Player.find(session[:user_id])
  puts(player.id)
  party = Party.find(params[:party_id])

  opponent_cards_on_hand = opponent.cards.where(:type => 'Distrito', :state => 'enMano').to_a
  player_cards_on_hand = player.cards.where(:type => 'Distrito', :state => 'enMano').to_a

  unless opponent_cards_on_hand.nil?

    opponent_cards_on_hand.each do |card|
      card.player_id = player.id
      card.save
    end

  end

  unless player_cards_on_hand.nil?

    player_cards_on_hand.each do |card|

      card.player_id = opponent.id
      card.save
    end

  end

  round = party.current_round
  action = player.actions.where(:name => "CHANGEWITHPLAYER", :round => round).first
  action.quantity -= 1
  action.save

  redirect_to party_path(params[:party_id])
end

def destroy_building

  card = Card.find(params[:card_id])
  party = Party.find(params[:party_id])
  player  = Player.find(session[:user_id])

  card.state = "enMazo"
  card.player_id = nil
  card.position = party.last_position()
  card.save

  player.coins -= card.cost - 1
  player.save

  round = party.current_round
  action = player.actions.where(:name => "DESTROYBUILDING", :round => round).first
  action.quantity -= 1
  action.save

  redirect_to party_path(params[:party_id])


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
