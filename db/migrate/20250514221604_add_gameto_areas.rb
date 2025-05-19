class AddGametoAreas < ActiveRecord::Migration[8.0]
  def change
    add_reference :areas, :game, null: false, foreign_key: true
  end
end
