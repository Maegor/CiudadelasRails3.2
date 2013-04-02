class RemoveNameFromBaseAction < ActiveRecord::Migration
  def up
    remove_column :base_actions, :name
  end

  def down
    add_column :base_actions, :name, :string
  end
end
