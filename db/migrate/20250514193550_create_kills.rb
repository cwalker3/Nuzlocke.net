class CreateKills < ActiveRecord::Migration[8.0]
  def change
    rename_table :trainer_pokemons, :trainer_pokemon

    create_table :kills do |t|
      t.references :user_pokemon, null: false, foreign_key: true
      t.references :trainer_pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
