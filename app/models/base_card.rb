class BaseCard < ActiveRecord::Base

  has_many :card_base_actions
  has_many :base_actions, :through => :card_base_actions
  has_many :cards

  attr_accessible :cost, :description, :name, :points, :quantity, :type, :turn, :colour

end
