class BaseAction < ActiveRecord::Base

  has_many :card_base_actions
  has_many :base_cards, :through => :card_base_actions
  has_many :actions
  has_many :players, :through => :actions

  attr_accessible :description, :name, :partialname


end
