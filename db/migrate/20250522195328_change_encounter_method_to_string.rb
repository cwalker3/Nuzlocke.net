class ChangeEncounterMethodToString < ActiveRecord::Migration[8.0]
  change_column :area_pokemon, :encounter_method, :string
end
