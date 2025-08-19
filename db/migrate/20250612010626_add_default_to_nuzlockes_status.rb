class AddDefaultToNuzlockesStatus < ActiveRecord::Migration[8.0]
  def change
    change_column_default :nuzlockes, :status, 0
    change_column_default :attempts, :status, 0
  end
end
