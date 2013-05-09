class Player < ActiveRecord::Base


  belongs_to :user
  belongs_to :party
  has_many :cards
  has_many :actions


  attr_accessible :coins,:position, :turn, :age, :name, :party_id, :user_id, :crown, :stolen, :murdered, :state, :points, :current
  attr_reader :numdistricts


  def numdistricts

        cards.districts.where("state = 'ONHAND'").count

  end

  def districts_on_hand

    cards.districts.where("state = 'ONHAND'")

  end

  def districts_on_game

    cards.districts.where("state = 'ONGAME'")

  end

  def player_character
    Card.characters.where("player_id = ?",id).first
  end



  def opponents

    party.players.order('id DESC').reject{|player| player.id == id}

  end

  def get_destrutible_building(target_player)

    list_cards = target_player.districts_on_game.find(:all, :conditions =>["name <> 'keep'"])
    great_wall = target_player.districts_on_game.exists?(["name = 'great_wall'"]) ? 1 : 0
    cost_list = Array.new(list_cards.length)
    cards_to_destroy = Array.new(list_cards.length)

    list_cards.each_with_index do |card,index|
      cost_list[index] = (card.base_card.cost - 1) + great_wall
    end
    for index in 0..(cost_list.length-1)
        if cost_list[index] <= coins
          cards_to_destroy[index] = list_cards[index]
        end
    end
    cards_to_destroy.compact
  end


  def call_action (action_array)

  if (action = actions.where(:id => action_array[0]).first)

      method  = method(action.base_action.partialname)

      if method.call(action_array)
        action.destroy
      end

      true

    else

      false

  end
end


  def points_recount()

    points = 0
    districts_on_game.each do |district|
    points = points + district.base_card.points

    end
       update_attribute(:points, points)
       points
  end


  def total_recount()

    self.points_recount
    player_districts =   districts_on_game.group('colour').length

    if player_districts.size >= 4
      self.points += 3
    end

     if  extra_districts = districts_on_game.group('colour').drop(8)
           self.points += extra_districts.size * 2
     end
      self.save
  end

  def recount
    points_distribution = Hash.new
    points = 0
    districts_on_game.each do |district|

      points = points + district.base_card.points
      points_distribution[:districts_points]= points

    end

    player_districts =   districts_on_game.count(:colour, :distinct => :colour)

    if player_districts >= 5
      points += 3
      points_distribution[:all_colors] = 3
    end
     points

    previous_players = party.players.order('turn ASC').take_while{|player| player.id != self.id}
    exist_player = previous_players.index{|player| player.districts_on_game.size >= 8}

    if (exist_player.nil? and districts_on_game.size >= 8)
      points += 4
      points_distribution[:first_eight] = 4
    elsif  districts_on_game.size >= 8
      points += 2
      points_distribution[:eight] = 2
    end


    check_special_card(points_distribution)
    points_distribution
  end

 def check_special_card(points_distribution)

     purple_districts = districts_on_game.where("colour = 'purple'")

   if purple_districts.exists?

     if purple_districts.exists?(["name = 'imperial_treasure'"])
       points_distribution[:imperial_treasure] = coins
     end

     if purple_districts.exists?(["name = 'map_room'"])
       points_distribution[:map_room] = districts_on_hand.count
     end

     if purple_districts.exists?(["name = 'fountain_wishes'"])
       points_distribution[:fountain_wishes] = purple_districts.count
     end

     if purple_districts.exists?(["name = 'museum'"])
       points_distribution[:museum] = cards.where("state = 'INMUSEUM'").count
     end
  end
end

  def action_end_turn
    purple_districts = districts_on_game.where("colour = 'purple'")

    if purple_districts.exists?(["name = 'poorhouse'"]) && coins == 0
      update_attribute(:coins, coins + 1)
    end

    if purple_districts.exists?(["name = 'park'"]) && districts_on_hand.count == 0

      cards = party.cards.districts.where("player_id is NULL").order('position').limit(2)
      cards.each do |card|
        Card.update(card.id, :state => 'ONHAND', :player_id => id)
      end
    end
  end

  def card_to_take
     districts_on_game.exists?(["name = 'library'"]) ? 2 : 1

  end

  def get_character()

    character = cards.where("type='Personaje'").first

    if character != nil
      character.name.downcase!
    end



  end


  #En esta funcion hay que tener en cuenta las cartas Factoria y Cantera
  #Factoria reduce el coste de los edificios purpuras en uno
  #Cantera permite costruir edificios repetidos
  def district_to_construct
    purple_districts = districts_on_game.where("colour = 'purple'")

    if purple_districts.exists?(["name = 'factory'"])
      no_played_cards = cards.districts.where("state = 'ONHAND' AND colour <> 'purple' AND cost <=" + coins.to_s).to_a
      no_played_cards.concat(cards.districts.where("state = 'ONHAND' AND colour = 'purple' AND cost <=" + (coins + 1).to_s).to_a)

    else

      no_played_cards = cards.districts.where("state = 'ONHAND' AND cost <=" + coins.to_s).to_a
    end

    if purple_districts.exists?(["name = 'quarry'"])
      district_to_build = no_played_cards.to_a
    else
      played_cards = cards.districts.where("state = 'ONGAME'")
      district_list = Array.new(no_played_cards)
      no_played_cards.each do |card_no_played|
        played_cards.each do |card_played|
          if card_no_played.base_card.name == card_played.base_card.name
            district_list.delete(card_no_played)
          end

        end

      end
      district_to_build = district_list
    end

    district_to_build.uniq{|district| district.base_card.name }
  end


  def add_coins(coins)

    self.coins += coins
    self.save
  end


  #Carga las acciones que puede realizar el jugador durante su turno
  def get_actions ()

    #acciones del personaje que esta jugando
    player_character.base_card.base_actions.each do |action|
      actions.create!(base_action_id: action.id)
    end

    #acciones por distritos morados

    purple_districts = districts_on_game.where("colour = 'purple' AND name <> 'lighthouse'")
    purple_districts.each do |district|
      district.base_card.base_actions.each do |action|
        actions.create!(base_action_id: action.id)
      end
    end




  end


#Calcula los impuestos teniendo en cuenta el personaje
# y  si tiene la carta school_magic
 def calculate_taxes

   character_name = player_character.base_card.name

   case character_name
     when 'merchant'
       colour = 'green'
     when 'king'
       colour = 'yellow'
     when 'warlord'
       colour = 'red'
     else
       colour = 'blue'
   end
   purple_district = districts_on_game.where("colour = 'purple'")
   colour_recount = cards.districts.where("state = 'ONGAME' AND colour = ?", colour).count + (purple_district.exists?(["name = 'school_magic'"])? 1:0)
 end

def player_actions

  actions.create(:base_action_id => BaseAction.find_by_partialname("take_gold").id)
  actions.create(:base_action_id => BaseAction.find_by_partialname("take_districts").id)

end

  def update_actions (actions_list)


    round = self.party.current_round

    actions_list.each do |name|
      action = self.actions.where(:name => name, :round => round).first
      action.quantity -= 1
      action.save
    end



  end

  def special_status

   if stolen == 'TRUE'

    thief_id = party.cards.characters.where("name = 'thief'").first.player_id
    thief = Player.find(thief_id)
    thief.update_attribute(:coins, thief.coins + self.coins)
    update_attributes(:coins => 0, :stolen => 'FALSE')

   end
  end


### Actions
 private
  def build (action_array)

   build_district(action_array)

  end

  def take_gold(action_array)
    new_state = String.new
    destroy_other_actions(action_array.first)
    if murdered == 'TRUE'
      new_state = 'WAITINGENDROUND'
    else
      new_state = 'ACTION'
      get_actions
    end
    update_attributes(:coins => self.coins + 2, :state => new_state)
    true
  end


  def take_districts(action_array)

    self.actions.create(:base_action_id => BaseAction.find_by_partialname("select_district").id)
    destroy_other_actions(action_array.first)

  end

  def select_district(action_array)
    exist = false
    if action_array.length > 1
    new_state = String.new
    cards = action_array.drop(1)
      cards.each do |card_id|
        Card.update(card_id,:player_id => self.id, :state => 'ONHAND')
      end
     party.reorder_cards()

    if murdered == 'TRUE'
      new_state = 'WAITINGENDROUND'
    else
      new_state = 'ACTION'
      get_actions
    end
     update_attribute(:state, new_state)
    exist = true
    end
    exist
  end

 def steal(action_array)

  exist = true
  card = Card.characters.find(:first,:conditions => ["cards.id = ? AND name <> 'assasin' AND state <> 'BACKS'", action_array[1]])

  if (card && card.party_id == party.id )
    Card.update(card.id, :stolen => 'TRUE')
   if card.player_id
    Player.update(card.player_id,:stolen => 'TRUE')
   end
  else
   exist = false
  end
   exist
 end


  def take_taxes(action_array)



    update_attribute(:coins, coins + calculate_taxes)
  end

  def extra_coin(action_array)

    update_attribute(:coins, coins + 1)

  end

  def kill(action_array)

    exist = true
    card = Card.find_by_id(action_array[1])

    if (card && card.party_id == self.party_id)
     card.update_attribute(:murdered, 'TRUE')
     if card.player_id
      Player.update(card.player_id,:murdered => 'TRUE')
     end
    else
       exist = false
    end
    exist
  end



  #destruye el distrito seleccionado
  #validaciones:
  # - estado de la carta es correcto
  # - cartas que modifican el comportamiento: obispo y great wall
  # - coste es menor o igual que las monedas disponibles
  def destroy_building (action_array)

   exist = false
   #card = Card.districts.where("name <> 'keep' AND cards.id = ? AND state = 'ONGAME'", action_array[1]).first
   card =  Card.districts.find(:first, :conditions =>  ["name <> 'keep' AND cards.id = ? AND state = 'ONGAME'", action_array[1]])
   current_coins = self.coins

   if (card && card.party_id == self.party_id)
    if (card.player.player_character.base_card.name != 'bishop')
     current_coins -= card.base_card.cost - 1 +(1 * (card.player.districts_on_game.exists?(["name = 'great_wall'"])? 1:0 ))
     if current_coins >= 0
       position = Array.new(1,party.last_position )
       #Si la carta destruir es el museo debemos actualizar las carta que estaban bajo el
       if card.base_card.name == 'museum'
         update_museum(card, position)
       end
      Card.update(card.id,:state => 'INDECK', :position => position[0], :player_id => nil)
      update_attribute(:coins, current_coins)
      exist = true
     end
    end
   end
   exist
  end

  def change_cards(action_array)
   exist = false
   if action_array.length >= 3
    action = action_array[1]

    method  = method(action)
    method.call(action_array.drop(2))
    exist  = true
    #actions.create!(base_action_id: BaseAction.find_by_partialname(action).id)
   end


  end

  def change_with_maze(cards_to_change)

   last_position = party.last_position
   unless cards_to_change.nil?

     cards_to_change.each do |id|

       Card.update(id, :state => 'INDECK', :position => last_position, :player_id => nil)
       last_position += 1

     end

     card_to_take = party.cards.districts.where("state = 'INDECK'").order("position ASC").limit(cards_to_change.size)

     card_to_take.each do |card|
       Card.update(card.id,:state => 'ONHAND', :player_id => id )
     end
   end
  end

  def change_with_player(action_array)
    opponent = Player.find(action_array[0])

    opponent_cards_on_hand = opponent.cards.districts.where("state = 'ONHAND'").to_a
    player_cards_on_hand = cards.districts.where("state = 'ONHAND'").to_a

    unless opponent_cards_on_hand.nil?

      opponent_cards_on_hand.each do |card|
        Card.update(card.id,:player_id => id)
      end
    end

    unless player_cards_on_hand.nil?
      player_cards_on_hand.each do |card|
        Card.update(card.id, :player_id => opponent.id)
     end
    end
  end

  def take_extra_cards(action_array)
    card_list = party.cards.districts.where("player_id is NULL").order('position').limit(2)
    card_list.each do |card|
      Card.update(card.id, :player_id => id, :state => 'ONHAND')
    end
  end

  def build_severals(action_array)
    build_district(action_array)
  end

  def build_district(action_array)

    districts_to_build = action_array.drop(1)
    costs = 0
    current_coins = self.coins
    cards = Array.new(districts_to_build.length)
    exist = true

    able_to_build = district_to_construct

    purple_districts = districts_on_game.where("colour = 'purple'")
    factory =  purple_districts.exists?(["name = 'factory'"])

   index = 0
   while (exist && index <= cards.length - 1) do
     district_id = districts_to_build[index]
     card = Card.find(district_id)
     if able_to_build.include?(card) && ( current_coins >= 0)

        current_coins  -= card.base_card.cost + (1 * ((factory && card.base_card.colour == 'purple')? 1:0 ))
        cards[index] = card

     else
        exist = false
     end
     index += 1
   end


    if  exist && (current_coins >= 0)
      cards.each do |card|
        card.update_attribute(:state, 'ONGAME')


        card_name = card.base_card.name

        case card_name
          when 'lighthouse'
            action = BaseAction.find_by_description('search_card')
            actions.create!(base_action_id: action.id)
          when 'powderhouse'
            action = BaseAction.find_by_description('self_destruction')
            actions.create!(base_action_id: action.id)
        end


      end
        update_attribute(:coins , current_coins)
    end


  exist
  end


  def destroy_other_actions(action_id)

    other_action = self.actions.where("id <> " + action_id).first
    other_action.destroy

  end


  def card_to_coin(action_array)
    #discard, the selected card return to the deck at last position
     Card.update(action_array[1], :state => 'INDECK', :position => party.last_position, :player_id => nil)
     update_attribute(:coins, coins + 1)

  end

  def coins_to_cards(action_array)

    exists = false
    if coins >= 3
    card_list = party.cards.districts.where("player_id is NULL").order('position').limit(3)
    card_list.each do |card|
      Card.update(card.id, :player_id => id, :state => 'ONHAND')
    end
    update_attribute(:coins, coins - 3)
      exists = true
    end
  end

  #powderhouse
  def self_destruction(action_array)
    exist = false
    card  = Card.districts.find(:first, :conditions => ["cards.id = ? AND state = 'ONGAME' AND name <> 'powderhouse'", action_array[1]], :readonly => false)

    if card && card.party_id == party_id

      #actualizamos el target

      position = Array.new(1, party.last_position) #Necesitamos pasar la position como referencia a la funcion update_museum
      card.update_attributes(:state => 'INDECK', :player_id => nil, :position => position[0])
      position[0] += 1

      #si la carta es el musuem entonces devolvemos las cartas con state 'INMUSEUM al mazo'
      if card.base_card.name == 'museum'
        update_museum(card, position)
      end

      #actualizamos el powderhouse
      powderhouse = cards.districts.find(:first, :conditions => ["name = 'powderhouse'"], :readonly => false)
      powderhouse.update_attributes(:state => 'INDECK', :player_id => nil, :position => position[0])
      exist = true
    end
    exist
  end


  def update_museum(card, position)

    inmuseum_cards = Card.districts.find(:all, :conditions => ["player_id = ? AND state = 'INMUSEUM'", card.player_id], :readonly => false)
    inmuseum_cards.each do |card|
      card.update_attributes(:state => 'INDECK', :position => position[0], :player_id => nil)
      position[0] += 1
    end


  end



  def search_card(action_array)

    exist = false
    card  = Card.districts.find(:first, :conditions => ["cards.id = ? AND state = 'INDECK'", action_array[1]], :readonly => false)

    if card && card.party_id == party_id

       card.update_attributes(:state => 'ONHAND', :player_id => id)
       exist = true
    end
    exist
  end


  def store_card(action_array)

    exist = false
    card = Card.districts.find(:first, :conditions => ["cards.id = ? AND state = 'ONHAND' AND player_id = ?", action_array[1], id], :readonly => false)

    if card && card.party_id == party_id
      card.update_attributes(:state => 'INMUSEUM')
      exist = true
    end
    exist
  end



end
