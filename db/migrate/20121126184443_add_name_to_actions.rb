class AddNameToActions < ActiveRecord::Migration
  def change
    add_column :actions, :name, :string
  end
end
