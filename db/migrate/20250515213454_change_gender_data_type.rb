class ChangeGenderDataType < ActiveRecord::Migration[8.0]
  def change
    remove_column :trainer_pokemon, :gender
    remove_column :attempt_pokemon, :gender

    add_column :trainer_pokemon, :gender, :string, limit: 1
    add_column :attempt_pokemon, :gender, :string, limit: 1
  end
end
