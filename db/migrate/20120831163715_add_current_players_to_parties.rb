class AddCurrentPlayersToParties < ActiveRecord::Migration
  def change
    add_column :parties, :current_player, :integer
  end
end
