class CreateWildPokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :wild_pokemons do |t|
      t.integer :method
      t.integer :rate
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
