class AddItemToGameItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :game_items, :item, null: false, foreign_key: true
  end
end
