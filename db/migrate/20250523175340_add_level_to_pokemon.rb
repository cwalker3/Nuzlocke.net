class AddLevelToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :trainer_pokemon, :level, :integer, null: false
  end
end
