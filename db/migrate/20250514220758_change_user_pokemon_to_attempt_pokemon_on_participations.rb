class ChangeUserPokemonToAttemptPokemonOnParticipations < ActiveRecord::Migration[8.0]
  def change
    remove_index :participations, name: "index_participations_on_user_pokemon_id"
    remove_column :participations, :user_pokemon_id
    add_reference :participations, :attempt_pokemon
  end
end
