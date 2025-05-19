class AddNotNullConstrainst < ActiveRecord::Migration[8.0]
  def change
    change_column_null :areas,       :name,            false
    change_column_null :games,       :title,           false
    change_column_null :items,       :name,            false
    change_column_null :items,       :image_file_name, false
    change_column_null :rules,       :name,            false
    change_column_null :pokemon,     :species,         false

    # splits must have name, number, and level_cap
    change_column_null :splits,      :name,            false
    change_column_null :splits,      :number,          false
    change_column_null :splits,      :level_cap,       false

    # enum/status columns
    change_column_null :nuzlockes,   :status,          false
    change_column_null :attempts,    :status,          false

    # item‐quantity join
    change_column_null :attempt_items, :quantity,      false

    # game_items must belong to a game
    change_column_null :game_items,  :game_id,         false

    # area_pokemon needs both method & rate defined
    change_column_null :area_pokemon, :encounter_method,         false
  end
end
