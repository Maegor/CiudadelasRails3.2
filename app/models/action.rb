class Action < ActiveRecord::Base

  belongs_to :player
  belongs_to :base_action

  attr_accessible :quantity, :round, :player_id, :name, :base_action_id





end
