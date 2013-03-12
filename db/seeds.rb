# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'molero1', email: 'molero1', password: '1234', password_confirmation: '1234', lang: 'en')
User.create!(name: 'molero2', email: 'molero2', password: '1234', password_confirmation: '1234', lang: 'en')
User.create!(name: 'molero3', email: 'molero3', password: '1234', password_confirmation: '1234', lang: 'en')

### Init base_actions

BaseAction.create!(name: 'take_gold', description: 'take_gold', partialname: 'take_gold')
BaseAction.create!(name: 'take_districts', description: 'take_districts', partialname: 'take_districts')
BaseAction.create!(name: 'select_district', description: 'select_district', partialname: 'select_district')
BaseAction.create!(name: 'kill', description: 'kill', partialname: 'kill')
BaseAction.create!(name: 'steal', description: 'steal', partialname: 'steal')
BaseAction.create!(name: 'taxes', description: 'take_yellow_taxes', partialname: 'take_taxes')
BaseAction.create!(name: 'taxes', description: 'take_red_taxes', partialname: 'take_taxes')
BaseAction.create!(name: 'taxes', description: 'take_blue_taxes', partialname: 'take_taxes')
BaseAction.create!(name: 'taxes', description: 'take_green_taxes', partialname: 'take_taxes')
BaseAction.create!(name: 'extra_gold', description: 'take_extra_gold', partialname: 'extra_coin')
BaseAction.create!(name: 'build', description: 'build', partialname: 'build')
BaseAction.create!(name: 'destroy', description: 'destroy', partialname: 'destroy_building')
BaseAction.create!(name: 'change', description:'change', partialname: 'change_cards')
BaseAction.create!(name: 'change_with_maze', description:'change_with_maze', partialname: 'change_with_maze')
BaseAction.create!(name: 'change_with_player', description:'change_with_player', partialname: 'change_with_player')
BaseAction.create!(name: 'crown', description:'crown', partialname: 'crown')
BaseAction.create!(name: 'protection', description: 'protection', partialname: 'protection')
BaseAction.create!(name: 'extra_districts', description: 'take_extra_districts', partialname: 'take_extra_cards')
BaseAction.create!(name: 'build_districts', description: 'build_several_districts', partialname: 'build_severals')

### Init base_cards

#Characters
Character.create!(name: 'assasin', turn: 1,quantity: 1,type: 'Character')
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

### Init card_base_action

build_id = BaseAction.find_by_name('build').id
# assasin's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('assasin').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('kill').id, base_card_id: BaseCard.find_by_name('assasin').id )
#thief's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('thief').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('steal').id, base_card_id: BaseCard.find_by_name('thief').id )
#magician's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('magician').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('change').id, base_card_id: BaseCard.find_by_name('magician').id )
#king's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('king').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('crown').id, base_card_id: BaseCard.find_by_name('king').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_yellow_taxes').id, base_card_id: BaseCard.find_by_name('king').id )
#bishop's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('bishop').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_blue_taxes').id, base_card_id: BaseCard.find_by_name('bishop').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('protection').id, base_card_id: BaseCard.find_by_name('bishop').id )
#merchant's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('merchant').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_green_taxes').id, base_card_id: BaseCard.find_by_name('merchant').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('extra_gold').id, base_card_id: BaseCard.find_by_name('merchant').id )
#architect's actions
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('extra_districts').id, base_card_id: BaseCard.find_by_name('architect').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('build_districts').id, base_card_id: BaseCard.find_by_name('architect').id )
#warlord's actions
CardBaseAction.create!(base_action_id: build_id, base_card_id: BaseCard.find_by_name('warlord').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_description('take_red_taxes').id, base_card_id: BaseCard.find_by_name('warlord').id )
CardBaseAction.create!(base_action_id: BaseAction.find_by_name('destroy').id, base_card_id: BaseCard.find_by_name('warlord').id )













