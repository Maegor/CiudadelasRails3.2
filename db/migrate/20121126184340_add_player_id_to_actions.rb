class AddPlayerIdToActions < ActiveRecord::Migration
  def change
    add_column :actions, :player_id, :integer
  end
end
