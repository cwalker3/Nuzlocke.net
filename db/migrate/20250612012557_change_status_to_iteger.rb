class ChangeStatusToIteger < ActiveRecord::Migration[8.0]
  def change
    remove_column :nuzlockes, :status, :integer
    remove_column :attempts, :status, :integer

    add_column :nuzlockes, :status,  :integer, default: 0, null: false
    add_column :attempts, :status, :integer, default: 0, null: false
  end
end
