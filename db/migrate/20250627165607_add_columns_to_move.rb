class AddColumnsToMove < ActiveRecord::Migration[8.0]
  def change
    create_table :types do |t|
      t.string :name
    end


    add_reference :moves, :game, null: false, foreign_key: true
    add_column :moves, :effect, :string, default: 'None'
    add_column :moves, :category, :integer
    add_column :moves, :power, :integer
    add_reference :moves, :type, foreign_key: true
    add_column :moves, :accuracy, :integer
    add_column :moves, :pp, :integer
    add_column :moves, :effect_chance, :integer
    add_column :moves, :targets, :string
    add_column :moves, :priority, :integer
  end
end
