class AddMissingForeignKeysAgain < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :kill_events,           :attempt_pokemon, column: :attempt_pokemon_id
    add_foreign_key :participation_events,  :attempt_pokemon, column: :attempt_pokemon_id

    add_index :attempt_items, [:attempt_id, :item_id], unique: true
    add_index :splits, [:game_id, :number], unique: true

    rename_column :area_pokemon, :method, :encounter_method
    rename_column :area_pokemon, :rate, :encounter_rate

    remove_column :game_items, :name

    drop_table :tests
    
  end
end
