class AddBoardPositionToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :board_position, :integer
  end
end
