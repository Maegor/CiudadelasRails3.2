class AddBellAffectedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :bell_affected, :boolean
  end
end
