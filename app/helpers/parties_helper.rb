module PartiesHelper


  def tooltip(array_points)
    string = String.new
    array_points.each do |key, value|

    string << (t key, :scope => [:points_recount])
    string << ' ' + value.to_s
    string << "\n"

    end
    string
  end

 def character_img(opponent)

    opponent_char = opponent.player_character
    if   %w(ACTION TURN WAITINGENDROUND).include?(opponent.state)
      render :partial => 'parties/opponent_char', :locals => {:opponent_char => opponent_char, :name => opponent.user.name}
    else
       ('<div class="opponent_iu" id="nochar"><div class="player_name">' + opponent.user.name.capitalize  + '</div></div>').html_safe
    end
  end

  def actions_tooltip(character_name)
    string = String.new

    string << (t 'characters.' + character_name + '.description')


  end

  def district_name(district_card)
    string = String.new
    #noinspection RubyResolve
    if district_card.base_card.colour == 'purple'
      string << (t 'districts.' + district_card.base_card.name + '.name')
    else
      string << (t 'districts.' + district_card.base_card.name.downcase)
    end
  end









  def district_tooltip(district_card)
    string = String.new
    #noinspection RubyResolve
    if district_card.colour == 'purple'
        string << (t 'districts.' + district_card.name + '.name').capitalize
        string << "\n"
        string << (t 'districts.' + district_card.name + '.description').capitalize
        if district_card.name == 'museum'
          #noinspection RubyResolve
          quantity = district_card.party.cards.find(:all, :conditions=>["state = 'INMUSEUM'"]).size
          string << "\n"
          string << (t 'board.district_under_museum', :quantity => quantity)
        end
    else

      string << (t 'districts.' + district_card.name)

    end

    string
  end

  def selected_class(other_class, index)
    div_class = String.new(other_class)
    if index == 0
      div_class << ' selected'
    else
      div_class << ' unselected'
    end
  end

  def visible_class(other_class, index)
    div_class = String.new(other_class)
    if index == 0
      div_class << ' visible'
    else
      div_class << ' hidden'
    end

  end

  def action_title(actions)

    title = String.new

    if actions.count == 2
      title << (t 'board.choose_action')
    else
       action = actions.first
       if action.player.districts_on_game.exists?(["name = 'library'"])

         title << (t 'board.draw_two_cards')

       else
         title << (t 'board.draw_one_card')
      end

    end

    title
  end


  def district_hash(districts)
    district_hash = Hash.new

    districts.each do |district|
      #noinspection RubyResolve
      district_hash[district.id] = district.base_card.cost
    end

    district_hash

  end


  def message_translator (message)

    out_string = String.new()
    message.message.split(' ').each do |string|
      out_string << (t string ,:actor_player => message.actor_player, :target_player => message.target_player)
    end
    out_string
  end

end
