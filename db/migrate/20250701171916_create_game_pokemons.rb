class CreateGamePokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :game_pokemon do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.integer :hp
      t.integer :atk
      t.integer :def
      t.integer :spa
      t.integer :spd
      t.integer :spe
      t.references :type_1, null: false, foreign_key: { to_table: :types}
      t.references :type_2, foreign_key: { to_table: :types}
      t.references :game, null: false

      t.timestamps
    end

    remove_column :pokemon, :hp
    remove_column :pokemon, :atk
    remove_column :pokemon, :def
    remove_column :pokemon, :spa
    remove_column :pokemon, :spd
    remove_column :pokemon, :spe
    remove_column :pokemon, :type_1_id
    remove_column :pokemon, :type_2_id
    remove_column :pokemon, :game_id

    remove_column :area_pokemon, :pokemon_id
    remove_column :trainer_pokemon, :pokemon_id
    remove_column :attempt_pokemon, :pokemon_id

    add_reference :area_pokemon, :game_pokemon
    add_reference :trainer_pokemon, :game_pokemon
    add_reference :attempt_pokemon, :game_pokemon
  end
end
