class RemoveImageFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :image
      end

  def down
    add_column :cards, :image, :string
  end
end
