class AddPlayerIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :player_id, :integer
  end
end
