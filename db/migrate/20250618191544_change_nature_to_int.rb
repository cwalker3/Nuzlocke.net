class ChangeNatureToInt < ActiveRecord::Migration[8.0]
  def change
    remove_column :attempt_pokemon, :nature, :string
    add_column :attempt_pokemon, :nature_id, :integer
  end
end
