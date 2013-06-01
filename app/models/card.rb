class Card < ActiveRecord::Base

  belongs_to :player
  belongs_to :party
  belongs_to :base_card

  scope :districts, joins(:base_card).where("type = 'District'")
  scope :characters, joins(:base_card).where("type = 'Character'")

  attr_accessible  :state, :party_id, :turn, :stolen, :murdered, :player_id, :base_card_id, :position, :round_update, :wasdestroyed




def update_owner (player_id)

      self.player_id = player_id

end

def update_status (status)


  self.state = status


end






end
