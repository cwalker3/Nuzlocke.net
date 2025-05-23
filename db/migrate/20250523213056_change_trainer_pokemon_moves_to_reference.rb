class ChangeTrainerPokemonMovesToReference < ActiveRecord::Migration[8.0]
  def change
    remove_column :trainer_pokemon, :move1, :string
    remove_column :trainer_pokemon, :move2, :string
    remove_column :trainer_pokemon, :move3, :string
    remove_column :trainer_pokemon, :move4, :string

    add_reference :trainer_pokemon, :move1, foreign_key: { to_table: :moves }, type: :bigint
    add_reference :trainer_pokemon, :move2, foreign_key: { to_table: :moves }, type: :bigint
    add_reference :trainer_pokemon, :move3, foreign_key: { to_table: :moves }, type: :bigint
    add_reference :trainer_pokemon, :move4, foreign_key: { to_table: :moves }, type: :bigint
  end
end
