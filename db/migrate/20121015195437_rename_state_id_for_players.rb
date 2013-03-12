class RenameStateIdForPlayers < ActiveRecord::Migration
  def up
    rename_column :players, :state_id, :state

  end

  def down
    rename_column :players, :state, :state_id

  end
end
