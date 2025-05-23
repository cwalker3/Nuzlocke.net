class ChangeAttemptStatusToInteger < ActiveRecord::Migration[8.0]
  def change
    change_column :attempts, :status, :string
    change_column :nuzlockes, :status, :string
  end
end
