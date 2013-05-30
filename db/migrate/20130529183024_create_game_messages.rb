class CreateGameMessages < ActiveRecord::Migration
  def change
    create_table :game_messages do |t|
      t.integer :party_id
      t.string :actor_player
      t.string :target_player
      t.string :message

      t.timestamps
    end
  end
end
