class AddNullOnTrainerName < ActiveRecord::Migration[8.0]
  def change
    change_column_null :trainers, :name, false
  end
end
