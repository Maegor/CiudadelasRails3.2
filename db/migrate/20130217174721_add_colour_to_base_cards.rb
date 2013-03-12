class AddColourToBaseCards < ActiveRecord::Migration
  def change
    add_column :base_cards, :colour, :string
  end
end
