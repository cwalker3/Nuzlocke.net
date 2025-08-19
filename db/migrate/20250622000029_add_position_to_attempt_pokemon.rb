class AddPositionToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :attempt_pokemon, :box_position, :integer
  end
end
