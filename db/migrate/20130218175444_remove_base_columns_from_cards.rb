class RemoveBaseColumnsFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :color
    remove_column :cards, :name
    remove_column :cards, :description
    remove_column :cards, :type
    remove_column :cards, :cost

  end

  def down

    add_column :cards, :color, :string
    add_column :cards, :name, :string
    add_column :cards, :description, :string
    add_column :cards, :type, :string
    add_column :cards, :cost, :integer

  end
end
