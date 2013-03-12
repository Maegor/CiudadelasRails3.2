class AddCurrentRoundToParties < ActiveRecord::Migration
  def change
    add_column :parties, :current_round, :integer
  end
end
