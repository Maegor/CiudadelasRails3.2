class AddAtrributesToCard < ActiveRecord::Migration
  def change
    add_column :cards, :murdered, :string
    add_column :cards, :stolen, :string
  end
end
