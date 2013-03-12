class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :image
      t.string :color
      t.text :description
      t.string :state

      t.timestamps
    end
  end
end
