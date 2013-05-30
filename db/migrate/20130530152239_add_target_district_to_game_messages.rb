class AddTargetDistrictToGameMessages < ActiveRecord::Migration
  def change
    add_column :game_messages, :target_district, :string
  end
end
