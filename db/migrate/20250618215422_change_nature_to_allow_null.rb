class ChangeNatureToAllowNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :attempt_pokemon, :area_id, true
  end
end
