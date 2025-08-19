class AddColumnDefaultToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    change_column_default :attempt_pokemon, :status, 0
  end
end
