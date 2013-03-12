class RenameAgeToCurrent < ActiveRecord::Migration
  def up
    rename_column :players, :age, :current
    change_column :players, :current, :string
  end

  def down

    rename_column :players, :current, :age
    change_column :players, :age, :integer

  end
end
