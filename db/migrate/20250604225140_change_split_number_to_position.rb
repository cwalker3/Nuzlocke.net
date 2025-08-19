class ChangeSplitNumberToPosition < ActiveRecord::Migration[8.0]
  def change
    rename_column :splits, :number, :position
  end
end
