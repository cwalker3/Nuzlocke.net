class ChangeStarterRequirmentNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :trainers, :starter_requirement, true
  end
end
