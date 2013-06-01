class AddDestroyedToCards < ActiveRecord::Migration
  def change
    add_column :cards, :wasdestroyed, :boolean
  end
end
