class RemoveCurrentPlayerFromParties < ActiveRecord::Migration
  def up
    remove_column :parties, :current_player

  end

  def down
    add_column :parties, :current_player, :integer
  end
end
