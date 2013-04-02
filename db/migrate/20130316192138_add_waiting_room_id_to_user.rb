class AddWaitingRoomIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :waiting_room_id, :integer
  end
end
