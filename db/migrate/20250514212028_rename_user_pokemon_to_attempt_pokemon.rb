class RenameUserPokemonToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    rename_table :user_pokemon, :attempt_pokemon
  end
end
