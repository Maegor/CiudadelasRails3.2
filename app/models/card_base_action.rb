class CardBaseAction < ActiveRecord::Base
  belongs_to :base_card
  belongs_to :base_action

  attr_accessible :base_action_id, :base_card_id
end
