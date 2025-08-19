class ChangePokemonIdToGamePokemonOnPokemonMoves < ActiveRecord::Migration[8.0]
  def change
    remove_reference :pokemon_moves, :pokemon
    add_reference :pokemon_moves, :game_pokemon, null: false, foreign_key: true
  end
end
