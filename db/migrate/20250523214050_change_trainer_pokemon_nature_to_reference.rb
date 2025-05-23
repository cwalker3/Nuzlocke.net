class ChangeTrainerPokemonNatureToReference < ActiveRecord::Migration[8.0]
  def change
    remove_column :trainer_pokemon, :nature, :string
    add_reference :trainer_pokemon, :nature, foreign_key: true
  end
end
