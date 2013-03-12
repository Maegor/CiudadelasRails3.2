class AddOrderToCards < ActiveRecord::Migration
  def change
    add_column :cards, :turn, :integer
  end
end
