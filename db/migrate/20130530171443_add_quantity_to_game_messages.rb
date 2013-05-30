class AddQuantityToGameMessages < ActiveRecord::Migration
  def change
    add_column :game_messages, :quantity, :integer
  end
end
