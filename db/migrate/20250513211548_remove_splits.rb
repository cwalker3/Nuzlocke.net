class RemoveSplits < ActiveRecord::Migration[8.0]
  def change
    drop_table :splits
  end
end
