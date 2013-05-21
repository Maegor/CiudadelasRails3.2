# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'molero1', email: 'molero1@pfc.net', password: '123456', password_confirmation: '123456', lang: 'en')
User.create!(name: 'molero2', email: 'molero2@pfc.net', password: '123456', password_confirmation: '123456', lang: 'en')
User.create!(name: 'molero3', email: 'molero3@pfc.net', password: '123456', password_confirmation: '123456', lang: 'en')

### Init base_actions

BaseAction.create!(description: 'take_gold', partialname: 'take_gold')
BaseAction.create!(description: 'take_districts', partialname: 'take_districts')
BaseAction.create!(description: 'select_district', partialname: 'select_district')
BaseAction.create!(description: 'kill', partialname: 'kill')
BaseAction.create!(description: 'steal', partialname: 'steal')
BaseAction.create!(description: 'take_yellow_taxes', partialname: 'take_taxes')
BaseAction.create!(description: 'take_red_taxes', partialname: 'take_taxes')
BaseAction.create!(description: 'take_blue_taxes', partialname: 'take_taxes')
BaseAction.create!(description: 'take_green_taxes', partialname: 'take_taxes')
#BaseAction.create!(description: 'extra_gold', partialname: 'extra_coin')
BaseAction.create!(description: 'build', partialname: 'build')
BaseAction.create!(description: 'destroy', partialname: 'destroy_building')
BaseAction.create!(description: 'change', partialname: 'change_cards')
BaseAction.create!(description: 'change_with_maze', partialname: 'change_with_maze')
BaseAction.create!(description: 'change_with_player', partialname: 'change_with_player')
#BaseAction.create!(description: 'crown', partialname: 'crown')
#BaseAction.create!(description: 'protection', partialname: 'protection')
BaseAction.create!(description: 'take_extra_cards', partialname: 'take_extra_cards')
BaseAction.create!(description: 'build_severals', partialname: 'build_severals')

#Actions of purple cards.
BaseAction.create!(description: 'card_to_coin', partialname: 'card_to_coin')
BaseAction.create!(description: 'coins_to_cards', partialname: 'coins_to_cards')
BaseAction.create!(description: 'self_destruction', partialname: 'self_destruction')
BaseAction.create!(description: 'search_card', partialname: 'search_card')
BaseAction.create!(description: 'store_card', partialname: 'store_card')


### Init base_cards

#Characters
Character.create!(name: 'assassin', turn: 1,quantity: 1,type: 'Character')
Character.create!(name: 'thief', turn: 2,quantity: 1, type: 'Character')
Character.create!(name: 'magician', turn: 3,quantity: 1, type: 'Character')
Character.create!(name: 'king', turn: 4,quantity: 1, type: 'Character')
Character.create!(name: 'bishop', turn: 5,quantity: 1,  type: 'Character')
Character.create!(name: 'merchant', turn: 6,quantity: 1,  type: 'Character')
Character.create!(name: 'architect', turn: 7,quantity: 1,  type: 'Character')
Character.create!(name: 'warlord', turn: 8,quantity: 1,  type: 'Character')
#green districts

District.create!(name:'tavern', colour:'green', cost:1, points:1, quantity:5, type:'District')
District.create!(name:'market', colour:'green', cost:2, points:2, quantity:4, type:'District')
District.create!(name:'store', colour:'green', cost:2, points:2, quantity:5, type:'District')
District.create!(name:'docks', colour:'green', cost:3, points:3, quantity:3, type:'District')
District.create!(name:'harbor', colour:'green', cost:4, points:4, quantity:3, type:'District')
District.create!(name:'town_hall', colour:'green', cost:5, points:5, quantity:2, type:'District')

=begin
#blue districts
District.create!(name:'temple', colour:'blue', cost:1, points:1, quantity:3, type:'District')

District.create!(name:'church', colour:'blue', cost:2, points:2, quantity:3, type:'District')
District.create!(name:'monastery', colour:'blue', cost:3, points:3, quantity:4, type:'District')
District.create!(name:'cathedral', colour:'blue', cost:4, points:4, quantity:2, type:'District')


#yellow districts
District.create!(name:'domain', colour:'yellow', cost:3, points:3, quantity:5, type:'District')

District.create!(name:'castle', colour:'yellow', cost:4, points:4, quantity:5, type:'District')
District.create!(name:'palace', colour:'yellow', cost:5, points:5, quantity:2, type:'District')

#red districts
District.create!(name:'watchtower', colour:'red', cost:1, points:1, quantity:3, type:'District')

District.create!(name:'prison', colour:'red', cost:2, points:2, quantity:3, type:'District')
District.create!(name:'barracks', colour:'red', cost:3, points:3, quantity:3, type:'District')
District.create!(name:'fortress', colour:'red', cost:5, points:5, quantity:3, type:'District')
=end
#purple
District.create!(name:'imperial_treasure', colour:'purple', cost:4, points:4, quantity:1, type:'District')
District.create!(name:'map_room', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'fountain_wishes', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'dragon_gate', colour:'purple', cost:6, points:8, quantity:1, type:'District')
District.create!(name:'university', colour:'purple', cost:6, points:8, quantity:1, type:'District')
District.create!(name:'keep', colour:'purple', cost:3, points:3, quantity:1, type:'District')
District.create!(name:'park', colour:'purple', cost:6, points:6, quantity:1, type:'District')
District.create!(name:'great_wall', colour:'purple', cost:6, points:6, quantity:1, type:'District')
District.create!(name:'poorhouse', colour:'purple', cost:4, points:4, quantity:1, type:'District')
District.create!(name:'library', colour:'purple', cost:6, points:6, quantity:1, type:'District')
District.create!(name:'quarry', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'factory', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'laboratory', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'smithy', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'school_magic', colour:'purple', cost:6, points:6, quantity:1, type:'District')
District.create!(name:'throne_hall', colour:'purple', cost:6, points:6, quantity:1, type:'District')
District.create!(name:'powderhouse', colour:'purple', cost:3, points:3, quantity:1, type:'District')
District.create!(name:'lighthouse', colour:'purple', cost:3, points:3, quantity:1, type:'District')
District.create!(name:'observatory', colour:'purple', cost:5, points:5, quantity:1, type:'District')
District.create!(name:'museum', colour:'purple', cost:4, points:4, quantity:1, type:'District')
District.create!(name:'hospital', colour:'purple', cost:6, points:6, quantity:1, type:'District')



### Init card_base_action

build_id = BaseAction.find_by_description('build').id
# assasin's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('assassin').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('kill').id, base_card_id: BaseCard.find_by_name('assassin').id )
#thief's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('thief').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('steal').id, base_card_id: BaseCard.find_by_name('thief').id )
#magician's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('magician').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('change').id, base_card_id: BaseCard.find_by_name('magician').id )
#king's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('king').id )
#CardBaseAction.create!(base_action_id: BaseAction.find_by_description('crown').id, base_card_id: BaseCard.find_by_name('king').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_yellow_taxes').id, base_card_id: BaseCard.find_by_name('king').id )
#bishop's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('bishop').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_blue_taxes').id, base_card_id: BaseCard.find_by_name('bishop').id )
#CardBaseAction.create!(base_action_id: BaseAction.find_by_description('protection').id, base_card_id: BaseCard.find_by_name('bishop').id )
#merchant's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('merchant').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_green_taxes').id, base_card_id: BaseCard.find_by_name('merchant').id )
#CardBaseAction.create!(base_action_id: BaseAction.find_by_description('extra_gold').id, base_card_id: BaseCard.find_by_name('merchant').id )
#architect's actions
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_extra_cards').id, base_card_id: BaseCard.find_by_name('architect').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('build_severals').id, base_card_id: BaseCard.find_by_name('architect').id )
#warlord's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('warlord').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_red_taxes').id, base_card_id: BaseCard.find_by_name('warlord').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('destroy').id, base_card_id: BaseCard.find_by_name('warlord').id )

#####  Purple cards

#Laboratory
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('card_to_coin').id, base_card_id: BaseCard.find_by_name('laboratory').id)
#smithy
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('coins_to_cards').id, base_card_id: BaseCard.find_by_name('smithy').id)
#powderhouse
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('self_destruction').id, base_card_id: BaseCard.find_by_name('powderhouse').id)
#lighthouse
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('search_card').id, base_card_id: BaseCard.find_by_name('lighthouse').id)
#museum
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('store_card').id, base_card_id: BaseCard.find_by_name('museum').id)












