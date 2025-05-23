class AddAbilityToTrainerPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :trainer_pokemon, :ability, null: false, foreign_key: true
  end
end
