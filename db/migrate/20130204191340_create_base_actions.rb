class CreateBaseActions < ActiveRecord::Migration
  def change
    create_table :base_actions do |t|
      t.string :name
      t.string :description
      t.string :partialname

      t.timestamps
    end
  end
end
