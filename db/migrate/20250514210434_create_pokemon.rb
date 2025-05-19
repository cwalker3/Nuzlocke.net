class CreatePokemon < ActiveRecord::Migration[8.0]
  def change
    create_table :pokemon do |t|
      t.string :name

      t.timestamps
    end
  end
end
