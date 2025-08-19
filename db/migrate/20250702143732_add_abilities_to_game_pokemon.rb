class AddAbilitiesToGamePokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :game_pokemon, :ability_1, null: false, foreign_key: { to_table: :abilities }
    add_reference :game_pokemon, :ability_2, foreign_key: { to_table: :abilities }
    add_reference :game_pokemon, :ability_3, foreign_key: { to_table: :abilities }
  end
end
