class RenamePlayerIdForUsers < ActiveRecord::Migration
  def up
    
    rename_column :users, :player, :player_id
  end

  def down
    
    rename_column :users, :player_id, :player
    
  end
end
