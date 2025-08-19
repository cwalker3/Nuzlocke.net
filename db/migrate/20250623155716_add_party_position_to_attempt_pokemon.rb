class AddPartyPositionToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :attempt_pokemon, :party_position, :integer
  end
end
