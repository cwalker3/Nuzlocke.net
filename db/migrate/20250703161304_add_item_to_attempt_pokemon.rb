class AddItemToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :attempt_pokemon, :item, foreign_key: true
  end
end
