class AddPokemonReferences < ActiveRecord::Migration[8.0]
  def change

    change_table :user_pokemon do |t|
      t.remove :species
      t.references :pokemon, null: false, foreign_key: true

      t.remove :hp_attack
      t.remove :hp_defense
      t.remove :hp_special_attack
      t.remove :hp_special_defense
      t.remove :hp_speed

      t.integer :attack_iv
      t.integer :defense_iv
      t.integer :special_attack_iv
      t.integer :special_defense_iv
      t.integer :speed_iv
    end
    end
end
