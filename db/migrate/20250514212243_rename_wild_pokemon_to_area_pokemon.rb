class RenameWildPokemonToAreaPokemon < ActiveRecord::Migration[8.0]
  def change
    rename_table :wild_pokemon, :area_pokemon
  end
end
