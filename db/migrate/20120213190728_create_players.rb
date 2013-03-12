class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :party_id
      t.integer :coins
      t.integer :numdistricts
      t.integer :age
      t.integer :state_id

      t.timestamps
    end
  end
end
