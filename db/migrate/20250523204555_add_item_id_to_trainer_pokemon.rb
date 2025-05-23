class AddItemIdToTrainerPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :trainer_pokemon, :item, foreign_key: true
  end
end
