class RemoveTableParties < ActiveRecord::Migration[8.0]
  def change
    drop_table :parties
  end
end
