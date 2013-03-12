class AddCrownToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :crown, :string
  end
end
