class RemoveNullFromTrainerPokemonAbility < ActiveRecord::Migration[8.0]
  def change
    change_column_null :trainer_pokemon, :ability_id, true
  end
end
