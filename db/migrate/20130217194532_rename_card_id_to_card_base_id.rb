class RenameCardIdToCardBaseId < ActiveRecord::Migration
 def change
   rename_column :card_base_actions, :card_id, :base_card_id
 end
end
