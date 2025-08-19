class AddColumnsToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_reference :pokemon, :game, null: false, foreign_key: true
    add_column :pokemon, :hp, :integer
    add_column :pokemon, :atk, :integer
    add_column :pokemon, :def, :integer
    add_column :pokemon, :spa, :integer
    add_column :pokemon, :spd, :integer
    add_column :pokemon, :spe, :integer
    add_reference :pokemon, :type_1, null: false, foreign_key: { to_table: :types}
    add_reference :pokemon, :type_2, null: true, foreign_key: { to_table: :types}, default: :null
  end
end
