class ChangeDataTypeForUserHashedPassword < ActiveRecord::Migration
  def up
    
    change_column :users, :hashed_password, :string
    
  end

  def down
    change_column :users, :hashed_password, :integer
  end
end
