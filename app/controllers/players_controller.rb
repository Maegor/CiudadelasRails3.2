class PlayersController < ApplicationController


  def take_extra_gold

    player = Player.find(params[:player_id])
    player. add_coins(1)

=begin
    round = player.party.current_round
    action = player.actions.where(:name => "OROEXTRA", :round => round).first
    action.quantity -= 1
    action.save
=end
    player.update_actions(["OROEXTRA"])

    redirect_to party_path(player.party.id)


  end


  def take_districts
    player = Player.find(params[:player_id])


=begin
    round = player.party.current_round

    ["TAKEGOLD","TAKEDISTRICTS"].each do |name|
      action = player.actions.where(:name => name, :round => round).first
      action.quantity -= 1
      action.save
    end
=end

    player.update_actions(["TAKEGOLD","TAKEDISTRICTS"])
    player.actions.create(:name => "SELECTDISTRICT", :player_id => player.id, :round => player.party.current_round, :quantity => 1)
    redirect_to party_path(player.party.id)

  end

  def take_extra_cards
    player = Player.find(params[:player_id])
    party = player.party

    player.update_actions(%w(TAKEEXTRACARDS))
    card_list = party.cards.where("type = 'Distrito' AND player_id is NULL").order('position').limit(2)
    card_list.each do |card|
      card.player_id = player.id
      card.state = 'enMano'
      card.save
    end
    redirect_to party_path(player.party.id)




  end
end
