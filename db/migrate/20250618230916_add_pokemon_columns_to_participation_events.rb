class AddPokemonColumnsToParticipationEvents < ActiveRecord::Migration[8.0]
  def change
    change_table :participation_events do |t|
      t.references :pokemon, null: false, foreign_key: true, index: true
      t.references :move_1, foreign_key: { to_table: :moves}, index: true
      t.references :move_2, foreign_key: { to_table: :moves}, index: true
      t.references :move_3, foreign_key: { to_table: :moves}, index: true
      t.references :move_4, foreign_key: { to_table: :moves}, index: true
      t.references :nature, foreign_key: true, index: true
      t.integer :hp_iv
      t.integer :attack_iv
      t.integer :defense_iv
      t.integer :special_attack_iv
      t.integer :special_defense_iv
      t.integer :speed_iv
    end
  end
end
