class CreateDefeatedTrainers < ActiveRecord::Migration[8.0]
  def change
    create_table :defeated_trainers do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
