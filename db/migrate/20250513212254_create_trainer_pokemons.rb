class CreateTrainerPokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :trainer_pokemons do |t|
      t.references :trainer, null: false, foreign_key: true
      t.integer :hp_iv
      t.integer :attack_iv
      t.integer :defense_iv
      t.integer :special_attack_iv
      t.integer :special_defense_iv
      t.integer :speed_iv
      t.string :nature
      t.string :move1
      t.string :move2
      t.string :move3
      t.string :move4

      t.timestamps
    end
  end
end
