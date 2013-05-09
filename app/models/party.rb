#noinspection ALL
class Party < ActiveRecord::Base


  PLAYERS_ENABLE = [2,3,4,5,6,7,8,9]



  has_many :players
  has_many :cards


  validates :name, :presence => true, :uniqueness => true
  attr_accessible :name, :numplayer, :user_id, :current_round, :state
  attr_accessor :last_position
  attr_reader :current_player






  def initialize_party(users)

    users.each do |user|
      add_player_to_party(user.id)
    end

    #Init districts

    create_district_cards
    shuffle_cards(cards.districts)
    distribute_cards(cards.districts)

    #Init characters

    create_characters_cards
    shuffle_cards(cards.characters)
    #Init players
    first_initialization_players

    round_initialization


  end


  def first_initialization_players

    player_list = players.shuffle
    player_list.each_with_index do |player, index|
    player.update_attributes(:turn => index,:position => index, :state => 'WAITING_SELECTION', :stolen => 'FALSE', :murdered => 'FALSE' )

    end

    king = player_list[0]
    king.crown = 'TRUE'
    king.save

  end


  def initialize_players

    king_id = cards.characters.where("name = 'king'").first.player_id
    previous_king = players.where(:crown => 'TRUE').first
    player_list = players.order("position ASC")
    position_array = Array.new(self.numplayer){|i| i}

     #Si el rey ha cambiado de mano rotamos la posiciones para que el rey
     #nuevo este en primera posicion
     #throne_room: cuando el rey cambia de manos el jugador que posee esta carta
     #recibe 1 oro
    if king_id and  king_id != previous_king.id

      throne_hall = cards.districts.find(:first, :conditions => ["name = 'throne_hall'"])

      player_id = throne_hall.player_id

      unless player_id.nil?
        player = Player.find(player_id)
        player.update_attribute(:coins, player.coins + 1)
      end


     king = Player.find(king_id)

     position_array = position_array.rotate(-1 * king.position)

     king.update_attribute(:crown, 'TRUE')
     previous_king.update_attribute(:crown, 'FALSE')

    end

    player_list.each_with_index do |player, index|
      player.update_attributes(:position => position_array[index], :turn => position_array[index], :state => 'WAITING_SELECTION', :stolen => 'FALSE', :murdered => 'FALSE')
    end
 end


  def create_district_cards


    district_list = District.all

    district_list.each do |district|

      district.quantity.times do

        cards.create!(state: 'INDECK', base_card_id: district.id)

      end
    end
  end



  def create_characters_cards

    character_list = Character.all

    character_list.each do |character|

      character.quantity.times do

        cards.create!(state: 'ONGAME', stolen: 'FALSE', murdered: 'FALSE', base_card_id: character.id)

      end
    end
  end

  def shuffle_cards(card_list)

    positions_array = Array.new(card_list.length)
    positions_array.fill{|i| i+1}

    positions_array.shuffle!

    card_list.each_with_index do |card, index|

      Card.update(card.id, :position => positions_array[index])

    end
  end

  def distribute_cards(card_list)

    card_list.sort_by! {|card| card.position}

    players.each_with_index do  |player, index|

      4.times do |t|
        card = card_list[(index*4)+t]
        Card.update(card.id, :player_id => player.id, :state => "ONHAND" )
      end
    end
  end


  def save_cards(cards)

     cards.each do |card|
       card.save
     end
  end

  def change_card_status (card, status)
    card.state = status
    card.save
  end



  def select_next_player(state)


  if state == 'TURN'
    player_list = players.where(:state=> 'WAITING_TURN').order('turn ASC')
  else
    player_list = players.where(:state => 'WAITING_SELECTION').order("turn ASC")
  end

  player_to_update = player_list.first

  if player_to_update

  player_to_update.update_attribute(:state, state)

    if state == 'TURN'

      player_to_update.player_actions

    end
   end
  end







#noinspection RubyResolve
  def tick
    if self.state == 'SELECTION_CHAR_STARTED'

      cards_with_player = cards.characters.where("player_id IS NOT NULL" )
      if cards_with_player.count == numplayer

          players.each do |player|

              player.turn = player.cards.characters.first.base_card.turn
              player.save
          end

       player_list = players.order('turn ASC')

          player_list.each_with_index do |player,index|

            player.turn = index
            player.save
          end

          next_player = players.order('turn ASC').first

           next_player.update_attribute(:state, 'TURN' )
           next_player.player_actions

        self.state = "GAME_PLAY_START"

        self.save

      else

        self.next_player

      end
    end


    if self.state == 'GAME_PLAY_START'

      players_waiting_end_round  = players.where(:state => 'WAITINGENDROUND')

      if players_waiting_end_round.size == numplayer
             player_max_district = players.sort{|x,y| y.districts_on_game.count <=> x.districts_on_game.count}.first

         if   player_max_district.districts_on_game.count >= 8
           #points_recount
           self.state='FINISHED'
           self.save
         else
           initialize_players
           round_initialization
           self.next_player
         end

      else
        self.next_character
      end
    end
  end

  #selecciona al próximo jugador en elegir personaje
  def next_player

    player_list = self.players.order('turn ASC').to_a

    waiting_players = player_list.count {|player| player.state == 'WAITING_SELECTION'}

    #si todos estan esperando cogemos al rey para que elija
    if waiting_players == self.numplayer


      player = player_list[0]
      player.state = 'SELECTION_TURN'
      player.save
    elsif waiting_players > 0

      selecting_player = player_list.index{|player|player.state == 'SELECTION_TURN'}

      if selecting_player.nil?

        player_index = player_list.index{|player|player.state == 'WAITING_SELECTION'}
        player = player_list[player_index]
        player.state= 'SELECTION_TURN'
        player.save
      end

    end



  end

  #selecciona el próximo personaje en jugar su turno
  def next_character

    player_list = players.order('turn ASC').to_a
    players_end = player_list.count {|player| player.state == 'WAITINGENDROUND'}
    if players_end < numplayer
        waiting_players = player_list.count {|player| player.state == 'WAITING_TURN'}

        if waiting_players > 0
          player_turn = player_list.index {|player| player.state == 'TURN' || player.state == 'ACTION'}

          if player_turn.nil?

            player_index = player_list.index {|player| player.state == 'WAITING_TURN'}

            #Comprobamos si el jugador tiene en juego la carta hospital
            player = player_list[player_index]

            hospital = player.districts_on_game.find(:first, :conditions => ["name = 'hospital'"])

            if player.murdered == 'TRUE' && hospital.nil?
              player.update_attribute(:state,'WAITINGENDROUND')
              next_character
            else
              player.update_attribute(:state,'TURN')
              player.player_actions
              player.special_status

            end
          end
        end
    else

      tick

    end
  end


   def points_recount

     player_list = players

         player_list.each do |player|
           player.total_recount()
           end
   end




  def round_initialization

    update_attribute(:state, 'ROUND_INIT' )

    cards_list = cards.characters.shuffle.to_a
    #TODO quitar el +1
    backs = 6 - (numplayer)
    if backs < 0
      backs = 0
    end


    cards_list.each do |card|

     Card.update(card.id, :player_id => nil, :stolen => 'FALSE', :murdered => 'FALSE', :state => nil )

    end


    first_card = cards_list.first

    Card.update(first_card.id, :state => 'REJECTED')

      cards_to_change_status = cards_list.drop(1)

    cards_to_backs = cards_to_change_status.take(backs)
    cards_to_backs.each do |card|
      Card.update(card.id, :state => 'BACKS')
    end

   cards_to_game =  cards_to_change_status.drop(backs)

    cards_to_game.each do |card|

      Card.update(card.id, :state => 'ONGAME')

    end


    if (index = cards_to_backs.index {|card| card.base_card.name == 'king'})

      king = cards_to_backs[index]

      Card.update(king.id, :state => 'ONGAME')
      other = cards_to_game.first
      Card.update(other.id, :state => 'BACKS')


    end

    update_attributes(:state => 'SELECTION_CHAR_STARTED', :current_round => current_round + 1 )
  end


  def card_to_select(player)

    limit = player.districts_on_game.exists?(["name = 'observatory'"]) ? 3 : 2
    card_list = cards.districts.where("player_id is NULL").order('position').limit(limit)
    card_list.each do |card|
      Card.update(card.id, :state => 'SELECTABLE')
    end
    card_list

  end

  def reorder_cards()

        last_position = cards.districts.order("position").last.position + 1
        no_selected_cards = cards.districts.where("state = 'SELECTABLE'")
        no_selected_cards.each_with_index do |card, index|

          Card.update(card.id, :state => 'INDECK', :position => last_position + index)

        end

  end



  def add_player_to_party (user_id)

   user = User.find(user_id)

    if numplayer != current_player

      players.create!(user_id: user_id, name: user.name, coins: 4, party_id: id, crown: 'FALSE', points: 0, current: 'TRUE')

      true

    else

      false

    end


end

  def last_position

    cards.districts.where("state='INDECK'").order("position ASC").last.position + 1

  end


  def current_player

    players.count

  end


  def as_json(options={})


    super(:only => [:name, :numplayer]  )

  end


  def players_to_destroy

    target_players = Array.new

    players.each do |player|

        if player.districts_on_game.size.between?(1,7)
           if player.player_character.base_card.name != 'bishop'
               target_players << player
           elsif player.murdered == 'TRUE'
                target_players << player
           end
        end
      end
    target_players
  end

  def cards_in_deck

    colours = BaseCard.find(:all,:select => "DISTINCT base_cards.colour").reject{|x| x.colour == nil}
    district_by_colours = Hash.new(colours.length)

    colours.each_with_index do |colour, index|
      district_in_deck = cards.districts.find(:all, :conditions => ["state = 'INDECK' AND colour = ?", colour.colour])
      district_by_colours[colour.colour] = district_in_deck.uniq{|card| card.base_card.name}
    end

    district_by_colours

  end

  def players_to_kill
    cards.characters.find(:all,:conditions => ["name <> 'assassin' AND state <> 'BACKS'"])
  end
  def players_to_steal
    cards.characters.find(:all, :conditions => ["name <> 'assassin' AND name <> 'thief' AND murdered <> 'TRUE'  AND state <> 'BACKS'"])
  end



end

