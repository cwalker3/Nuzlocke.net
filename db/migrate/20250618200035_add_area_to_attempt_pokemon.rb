class AddAreaToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :attempt_pokemon, :area, null: false, foreign_key: true
  end
end
