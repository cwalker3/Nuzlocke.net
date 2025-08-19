class AddMovesToAttemptPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :attempt_pokemon, :move_1, foreign_key: { to_table: :moves }
    add_reference :attempt_pokemon, :move_2, foreign_key: { to_table: :moves }
    add_reference :attempt_pokemon, :move_3, foreign_key: { to_table: :moves }
    add_reference :attempt_pokemon, :move_4, foreign_key: { to_table: :moves }
  end
end
