class AddBaseCardIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :base_card_id, :integer
  end
end
