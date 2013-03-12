# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130309195049) do

  create_table "actions", :force => true do |t|
    t.integer  "round"
    t.integer  "quantity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "player_id"
    t.string   "name"
    t.integer  "base_action_id"
  end

  create_table "base_actions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "partialname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "base_cards", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cost"
    t.integer  "points"
    t.integer  "quantity"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "turn"
    t.string   "colour"
  end

  create_table "card_base_actions", :force => true do |t|
    t.integer  "base_card_id"
    t.integer  "base_action_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.integer  "party_id"
    t.integer  "position"
    t.integer  "turn"
    t.string   "murdered"
    t.string   "stolen"
    t.integer  "base_card_id"
  end

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.integer  "numplayer"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_round"
  end

  create_table "players", :force => true do |t|
    t.integer  "user_id"
    t.integer  "party_id"
    t.integer  "coins"
    t.string   "current"
    t.text     "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "turn"
    t.string   "crown"
    t.integer  "position"
    t.integer  "points"
    t.string   "murdered"
    t.string   "stolen"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "lang"
  end

end
