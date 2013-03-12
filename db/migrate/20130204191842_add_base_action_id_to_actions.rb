class AddBaseActionIdToActions < ActiveRecord::Migration
  def change
    add_column :actions, :base_action_id, :integer
  end
end
