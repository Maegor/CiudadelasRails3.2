class CreateCardBaseActions < ActiveRecord::Migration
  def change
    create_table :card_base_actions do |t|
      t.integer :card_id
      t.integer :base_action_id

      t.timestamps
    end
  end
end
