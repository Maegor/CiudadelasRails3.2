class RemovePlayerIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :player_id
  end

  def down
    remove_column :users, :player_id, :interger

  end
end
