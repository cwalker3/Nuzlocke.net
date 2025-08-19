class AddDexNumberToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :pokemon, :dex_number, :integer
  end
end
