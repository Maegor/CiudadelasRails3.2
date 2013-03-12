class AddAttributesToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :murdered, :string
    add_column :players, :stolen, :string
  end
end
