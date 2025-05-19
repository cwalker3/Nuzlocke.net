class RenameItemsToGameItems < ActiveRecord::Migration[8.0]
  def change
    rename_table :items, :game_items

    add_reference :game_items, :game, foreign_key: true, index: true
    add_column :game_items, :quantity, :integer

  end
end
