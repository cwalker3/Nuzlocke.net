class ChangeStatusNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :nuzlockes, :status, true
    change_column_null :attempts, :status, true
  end
end
