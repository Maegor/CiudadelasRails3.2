class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :round
      t.integer :quantity

      t.timestamps
    end
  end
end
