class AddTurnToBaseCards < ActiveRecord::Migration
  def change
    add_column :base_cards, :turn, :integer
  end
end
