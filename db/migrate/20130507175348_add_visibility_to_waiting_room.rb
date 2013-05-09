class AddVisibilityToWaitingRoom < ActiveRecord::Migration
  def change
    add_column :waiting_rooms, :visible, :boolean
  end
end
