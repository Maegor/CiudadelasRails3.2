class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :password
      t.integer :player

      t.timestamps
    end
  end
end
