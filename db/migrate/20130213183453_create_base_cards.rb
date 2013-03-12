class CreateBaseCards < ActiveRecord::Migration
  def change
    create_table :base_cards do |t|
      t.string :name
      t.string :description
      t.integer :cost
      t.integer :points
      t.integer :quantity
      t.string :type

      t.timestamps
    end
  end
end
