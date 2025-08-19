class AddMinLevelToAreaPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :area_pokemon, :min_level, :integer
    add_column :area_pokemon, :max_level, :integer
  end
end
