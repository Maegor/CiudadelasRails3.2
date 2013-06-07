class PlayersController < ApplicationController

#TODO borrar
=begin
  def take_extra_gold

    player = Player.find(params[:player_id])
    player.add_coins(1)



    round = player.party.current_round
    action = player.actions.where(:name => "OROEXTRA", :round => round).first
    action.quantity -= 1
    action.save


    player.update_actions(["OROEXTRA"])

    redirect_to party_path(player.party.id)


  end
=end


  def take_extra_cards
    player = Player.find(params[:player_id])
    party = player.party

    player.update_actions(%w(TAKEEXTRACARDS))
    #noinspection RubyResolve
    card_list = party.cards.where("type = 'Distrito' AND player_id is NULL").order('position').limit(2)
    card_list.each do |card|
      card.player_id = player.id
      card.state = 'enMano'
      card.save
    end
    redirect_to party_path(player.party.id)




  end
end
