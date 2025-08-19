class AddAttemptNumberToAttempt < ActiveRecord::Migration[8.0]
  def change
    add_column :attempts, :number, :integer, null: false
  end
end
