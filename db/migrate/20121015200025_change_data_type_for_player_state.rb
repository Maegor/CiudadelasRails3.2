class ChangeDataTypeForPlayerState < ActiveRecord::Migration
  def up
    change_column :players, :state, :text
  end

  def down
    change_column :players, :state, :integer
  end
end
