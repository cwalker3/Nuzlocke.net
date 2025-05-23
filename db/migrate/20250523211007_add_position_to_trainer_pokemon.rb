class AddPositionToTrainerPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :trainer_pokemon, :position, :integer, null: false
  end
end
