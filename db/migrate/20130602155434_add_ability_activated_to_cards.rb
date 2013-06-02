class AddAbilityActivatedToCards < ActiveRecord::Migration
  def change
    add_column :cards, :ability_activated, :boolean
  end
end
