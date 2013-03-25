module PartiesHelper

  def count_points(array_points)
    points = 0
    array_points.each do |key,value|
      points += value

    end
      points

  end

  def tooltip(array_points)
    string = String.new
    array_points.each do |key, value|

    string << (t key, :scope => [:points_recount])
    string << " " + value.to_s
    string << "\n"

    end
    string
  end


  def character_img(opponent)

    character_card = opponent.player_character
    if   ['ACTION', 'TURN', 'WAITINGENDROUND'].include?(opponent.state)
      render :partial => 'character_card', :object => character_card
    else
       '<div class="card" id="cardback"></div>'.html_safe
    end
  end
  
end
