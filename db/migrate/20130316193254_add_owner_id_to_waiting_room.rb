class AddOwnerIdToWaitingRoom < ActiveRecord::Migration
  def change
    add_column :waiting_rooms, :owner_id, :integer
  end
end
