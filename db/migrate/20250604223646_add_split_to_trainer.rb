class AddSplitToTrainer < ActiveRecord::Migration[8.0]
  def change
    add_reference :trainers, :split, null: false, foreign_key: true
  end
end
