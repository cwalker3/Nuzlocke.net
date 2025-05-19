class AddGenderToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :trainer_pokemon, :gender, :integer
    add_column :attempt_pokemon, :gender, :integer

    remove_column :trainers, :mandatory
    add_column :trainers, :type, :integer
  end
end
