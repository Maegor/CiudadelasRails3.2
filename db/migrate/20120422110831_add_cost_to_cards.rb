class AddCostToCards < ActiveRecord::Migration
  def change
    add_column :cards, :cost, :integer
  end
end
