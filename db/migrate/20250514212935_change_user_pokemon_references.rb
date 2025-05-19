class ChangeUserPokemonReferences < ActiveRecord::Migration[8.0]
  def change
    remove_index :kills, column: :user_pokemon_id
    change_table :kills do |t|
      t.remove :user_pokemon_id

      t.references :attempt_pokemon
    end
  end
end
