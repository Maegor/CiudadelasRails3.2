class RemoveNumdistrictsFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :numdistricts
  end

  def down
    add_column :players, :numdistricts, :integer
  end
end
