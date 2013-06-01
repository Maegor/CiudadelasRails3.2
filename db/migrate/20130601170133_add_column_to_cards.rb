class AddColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :round_update, :integer
  end
end
