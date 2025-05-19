class RenameWildPokemonsToWildPokemon < ActiveRecord::Migration[8.0]
  def change
    rename_table :wild_pokemons, :wild_pokemon
  end
end
