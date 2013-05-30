class GameMessage < ActiveRecord::Base
  belongs_to :party
  attr_accessible :actor_player, :message, :party_id, :target_player, :target_district, :quantity
end
