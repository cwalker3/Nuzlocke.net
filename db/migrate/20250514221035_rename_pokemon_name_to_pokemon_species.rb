class RenamePokemonNameToPokemonSpecies < ActiveRecord::Migration[8.0]
  def change
    rename_column :pokemon, :name, :species
  end
end
