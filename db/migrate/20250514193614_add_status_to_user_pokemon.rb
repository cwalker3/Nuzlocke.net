class AddStatusToUserPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :user_pokemon, :status, :integer
  end
end
