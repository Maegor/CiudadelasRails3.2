class AddPointsHashToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :points_hash, :text
  end
end
