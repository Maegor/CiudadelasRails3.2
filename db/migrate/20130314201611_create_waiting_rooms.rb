class CreateWaitingRooms < ActiveRecord::Migration
  def change
    create_table :waiting_rooms do |t|
      t.integer :user
      t.string :name

      t.timestamps
    end
  end
end
