class AddPokemonToArePokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :area_pokemon, :pokemon, null: false, foreign_key: true
  end
end
